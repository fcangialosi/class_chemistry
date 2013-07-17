	require 'nokogiri'
	require 'open-uri'
	require 'logger'

	def strip(str) if(str != nil) then return str.delete("\n").delete("\t").delete("\r") end end

	starting = Time.now

	log = Logger.new('seeding_log.txt')

	# Get all the departments
	doc = Nokogiri::HTML(open("https://ntst.umd.edu/soc/index.html?term=201308"))
	departments = doc.css("span.prefix-abbrev").map {|e| "#{strip(e.text)}"}
	departments.push("FSAW", "FSAR", "FSMA", "FSOC", "FSPW", "DSHS", "DSHU", "DSNS", "DSNL", "DSSP", "DVCC", "DVUP", "SCIS")
	
	# Used to check whether or not a page fits into one of these categories
	gened = ["FSAW", "FSAR", "FSMA", "FSOC", "FSPW", "DSHS", "DSHU", "DSNS", "DSNL", "DSSP", "DVCC", "DVUP", "SCIS"]
	no_sections_pages = ["BISI", "ENBE", "IVSP", "MUSP", "SLAV"]
	no_sections_classes = []
	empty_list = ["EMBA", "MAIT", "NIAP", "NIAS"]

	##### Seed Sections Table #####
	departments.each do |page|

		if(no_sections_pages.include?(page) || empty_list.include?(page)) # Skip this page if it has no section info or is empty
			next
		end

		log.info("Parsing and storing section info for #{page} classes...")
		puts "Parsing and storing section info for #{page} classes..."

		f = File.open("./db/classpages/#{page}.html")
		doc = Nokogiri::HTML(open(f))
		f.close

	  	courses = doc.css("div.course").map {|e| e} # divide into an array of the separate HTML for each section

	  	courses.each do |course|
	  		course_name = strip(course.css("div.course-id").text) # CMSC250
	  		sections = course.css("div.section").map {|e| e} # make array of the HTML for each section in this class

	  		if(sections.empty?) # if this course doesn't have any sections, skip it, nothing to save
	  			no_sections_classes.push(course_name) # keep track of those without sections, can't add section specific info to course later
	  			next
	  		end

	  		sections.each do |s|
	  			section_code = strip(s.css("span.section-id").text) # 0101
	  			section = Section.find_or_create_by_identifier("#{section_code+course_name}") # looks like 0101CMSC250

	  			professor = strip(s.css("span.section-instructor").text)
	  			total = strip(s.css("span.total-seats-count").text).to_i
	  			open = strip(s.css("span.open-seats-count").text).to_i
	  			waitlist = strip(s.css("span.watlist-count").text).to_i

				rows = s.css("div.row").map {|e| e} # each line of a section box is a row

				# the second row has information about the lecture (the first has section num and seats)
				days = rows[1].css("span.section-days").text
				start_time = rows[1].css("span.class-start-time").text
				end_time = rows[1].css("span.class-end-time").text
				building = rows[1].css("span.building-code").text
				room = rows[1].css("span.class-room").text

				section.update_attributes(
					:course_code => course_name,
					:section_num => section_code,
					:professor => professor,
					:seats_total => total,
					:seats_open => open,
					:seats_waitlist => waitlist,

					:lecture_days => days,
					:lecture_start => start_time,
					:lecture_end => end_time,
					:lecture_building => building,
					:lecture_room => room
					)

	  			# if there is a third row, then the section has a discussion, and the row contains this info
	  			if(rows.size == 3)
	  				days = rows[2].css("span.section-days").text
	  				start_time = rows[2].css("span.class-start-time").text
	  				end_time = rows[2].css("span.class-end-time").text
	  				building = rows[2].css("span.building-code").text
	  				room = rows[2].css("span.class-room").text
	  				section.update_attributes(
	  					:has_discussion => true,
	  					:disc_days => days,
	  					:disc_start => start_time,
	  					:disc_end => end_time,
	  					:disc_building => building,
	  					:disc_room => room
	  					)	
	  			end
	  		end
	  	end

	  	log.info("#{page} page completed.\n")
	  	puts "#{page} page completed.\n"
	end

	##### Seed Courses Table #####
	departments.each do |page| 

		if(empty_list.include?(page))
			next
		end

		log.info("Parsing and storing classes from the #{page} page...")
		puts "Parsing and storing classes from the #{page} page..."

	  # Which page to parse
	  f = File.open("./db/classpages/#{page}.html")
	  doc = Nokogiri::HTML(open(f))
	  f.close

	  # Create arrays of info
	  title = doc.css('span.course-title').map { |e| "#{e.text}" }
	  id = doc.css('div.course-id').map { |e| "#{e.text}" }
	  credits = doc.css('span.course-min-credits').map { |e| "#{e.text}" }
	  description = doc.css('div.approved-course-text').map { |e| "#{e.text}" } 
	  
	  if(gened.include?(page)) # Only parse gened codes if this is a gened page
	  	gened_codes = doc.css("div.gen-ed-codes-group").map { |e| "#{strip(e.text)[6..-1].delete(",")}"} # cotains all the codes for a single class in the form: "TYPE1(or) TYPE2(or) TYPE3", may have anywhere from 1 - 3 types, and may contain "or"s
	  end

	  # Create and fill courses on the database
	  title.size.times do |x|
	  	course = Course.find_or_create_by_course_code("#{id[x]}")
	  	course.update_attributes(department: "#{id[x][0..3]}", course_num: "#{id[x][4..6]}", course_code: "#{id[x]}", name: "#{title[x]}", credits: credits[x].to_i, description: "#{description[x]}") 

	  	if(!no_sections_classes.include?("#{id[x]}") && !no_sections_pages.include?(page)) # Only add this information if it has section information
			# Calculate total number of seats from all sections
			sections = Section.all(:conditions => {:course_code => "#{id[x]}"})
			open = 0
			total = 0
			sections.each do |s|
				open += s.seats_open
				total += s.seats_total
			end

			# Find the number of unique professor names among all sections of this class
			professors = []
			num_professors = 0
			sections.each do |s|
				if !professors.include?(s.professor)
					num_professors+=1
					professors.push(s.professor)
				end
			end

			# Remove all TBA instructors from the list now that we know how many there are, to be able to find the first real one
			professors.each do |p|
				if p.eql?("Instructor: TBA")
					professors.delete(p)
				end
			end

			# Just incase all were TBA, lets add one back, that's the best we can do
			professors.push("Instructor: TBA")
		
			# Add the numer of seats, professors, and the name of the first non-null professor listed 
			course.update_attributes(:open_seats => open, :total_seats => total, :num_professors => num_professors, :professor => professors[0])
		end

		# all classes default to undergrad, only change to grad if course num is greater than 499
		if id[x][4..6].to_i > 499
			course.update_attributes(:undergrad => false)
		end
	  	# set appropriate gened code filters, but only if this is a gened page
	  	if(gened.include?(page))
	  		course.update_attributes(:gened_codes => "#{gened_codes[x]}")
	  	end
	  end
	end

	log.info("=====All parsing complete!=====")
	puts "=====All parsing complete!====="

	puts "\nCompleted in #{Time.now - starting} seconds"
