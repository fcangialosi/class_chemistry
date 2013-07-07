	require 'nokogiri'
	require 'open-uri'
	require 'logger'

	def strip(str) if(str != nil) then return str.delete("\n").delete("\t").delete("\r") end end

	log = Logger.new('seeding_log.txt')

	doc = Nokogiri::HTML(open("https://ntst.umd.edu/soc/index.html?term=201308"))
	departments = doc.css("span.prefix-abbrev").map {|e| "#{strip(e.text)}"}
	departments.push("FSAW", "FSAR", "FSMA", "FSOC", "FSPW", "DSHS", "DSHU", "DSNS", "DSNL", "DSSP", "DVCC", "DVUP", "SCIS")

	departments.each do |page|

		log.info("Parsing and storing section info for #{page} classes...")
		puts "Parsing and storing section info for #{page} classes..."

		f = File.open("./db/classpages/#{page}.html")
	  	doc = Nokogiri::HTML(open(f))
	  	f.close

	  	courses = doc.css("div.course").map {|e| e} # divide into an array of the separate HTML for each section

	  	courses.each do |course|
	  		course_name = strip(course.css("div.course-id").text) # CMSC250
	  		sections = course.css("div.section").map {|e| e} # make array of the HTML for each section in this class

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

=begin
gened.each do |page| 

	  log.info("Parsing and storing classes from #{page} GenEd page...")
	  puts "Parsing and storing classes from #{page} GenEd page..."

	  # Which page to parse
	  f = File.open("./db/classpages/#{page}.html")
	  doc = Nokogiri::HTML(open(f))
	  f.close

	  title = doc.css('span.course-title').map { |e| "#{e.text}" }
	  id = doc.css('div.course-id').map { |e| "#{e.text}" }
	  credits = doc.css('span.course-min-credits').map { |e| "#{e.text}" }
	  description = doc.css('div.approved-course-text').map { |e| "#{e.text}" } 
	  gened = doc.css("div.gen-ed-codes-group").map { |e| "#{strip(e.text)}" } # cotains all the codes for a single class in the form: "GenEd: TYPE1, TYPE2, TYPE3", may have anywhere from 1 - 3 types

	  title.size.times do |x|
	    course = Course.find_or_create_by_course_code("#{id[x]}")
		course.update_attributes(department: "#{id[x][0..3]}", course_num: "#{id[x][4..6]}", course_code: "#{id[x]}", name: "#{title[x]}", credits: credits[x].to_i, description: "#{description[x]}") 
		
		# Calculate total number of seats from all sections
		sections = Section.find_by_course_code("#{id[x]}")
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
		  	professors.push s.professor
		  end
		end
		# Remove all TBA instructors from the list now that we know how many there are, to be able to find the first real one
		professors.each do |p|
			if p.equals?("Instructor: TBA")
				professors.delete(p)
			end
		end
		# Just incase all were TBA, lets add one back
		professors.push("Instructor: TBA")
		
		# Add the numer of seats, professors, and the name of the first non-null professor listed 
		course.update_attributes(:open_seats => open, :total_seats => total, :num_professors => num_professors, :professor => professors[0])

		# all classes default to undergrad, only change to grad if course num is greater than 499
		if id[x][0..3].to_i > 499
			course.update_attributes(:undergrad => false)

	  	# set appropriate gened code filters
	  	if gened[x].include? 'FSAW'
	  		course.update_attributes(:FSAW => true)
	  	end
	  	if gened[x].include? 'FSAR'
	  		course.update_attributes(:FSAR => true)
	  	end
	  	if gened[x].include? 'FSMA'
	  		course.update_attributes(:FSMA => true)
	  	end
	  	if gened[x].include? 'FSOC'
	  		course.update_attributes(:FSOC => true)
	  	end
	  	if gened[x].include? 'FSPW'
	  		course.update_attributes(:FSPW => true)
	  	end
	  	if gened[x].include? 'DSHS'
	  		course.update_attributes(:DSHS => true)
	  	end
	  	if gened[x].include? 'DSHU'
	  		course.update_attributes(:DSHU => true)
	  	end
	  	if gened[x].include? 'DSNS'
	  		course.update_attributes(:DSNS => true)
	  	end
	  	if gened[x].include? 'DSNL'
	  		course.update_attributes(:DSNL => true)
	  	end
	  	if gened[x].include? 'DSSP'
	  		course.update_attributes(:DSSP => true)
	  	end
	  	if gened[x].include? 'DVCC'
	  		course.update_attributes(:DVCC => true)
	  	end
	  	if gened[x].include? 'DVUP'
	  		course.update_attributes(:DVUP => true)
	  	end
	  	if gened[x].include? 'SCIS'
	  		course.update_attributes(:SCIS => true)
	  	end
	  	if gened[x].include? 'DSHSor DSHU'
	  		course.update_attributes(:HSorHU => true)
	  	end
	  	if gened[x].include? 'DSHSor DSSP'
	  		course.update_attributes(:HSorSP => true)
	  	end
	  	if gened[x].include? 'DSHSor DSNS'
	  		course.update_attributes(:HSorNS => true)
	  	end
	  	if gened[x].include? 'DSHUor DSSP'
	  		course.update_attributes(:HUorSP => true)
	  	end
	  	if gened[x].include? 'DSNLor DSSP'
	  		course.update_attributes(:NLorSP => true)
	  	end
	  	if gened[x].include? 'DSHSor DSHUor DSSP'
	  		course.update_attributes(:HSorHUorSP => true)
	  	end
	  	if gened[x].include? 'DSNLor DSNSor DSSP'
	  		course.update_attributes(:NLorNSorSP => true)
	  	end
      end
	end

	log.info("=====GenEd parsing complete!=====\n Now the rest...")
	puts "=====GenEd parsing complete!=====\n Now the rest..."

	departments.each do |page|

	  log.info("Parsing and storing classes from #{page} page...")
	  puts "Parsing and storing classes from #{page} page..."

	  f = File.open("./db/classpages/#{page}.html")
	  doc = Nokogiri::HTML(open(f))
	  f.close

	  title = doc.css('span.course-title').map { |e| "#{e.text}" }
	  id = doc.css('div.course-id').map { |e| "#{e.text}" }
	  credits = doc.css('span.course-min-credits').map { |e| "#{e.text}" }
	  description = doc.css('div.approved-course-text').map { |e| "#{e.text}" } 
	  
	  title.size.times do |x|
	    course = Course.find_or_create_by_course_code("#{id[x]}")
		course.update_attributes(department: "#{id[x][0..3]}", course_num: "#{id[x][4..6]}", course_code: "#{id[x]}", name: "#{title[x]}", credits: credits[x].to_i, description: "#{description[x]}") 
	  end
	end

	log.info("=====All parsing complete!=====")
	puts "=====All parsing complete!====="
=end
