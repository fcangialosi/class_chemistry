require 'nokogiri'
require 'open-uri'

def strip(str) if(str != nil) then return str.delete("\n").delete("\t") end end

pages = ["FSAW", "FSAR", "FSMA", "FSOC", "FSPW", "DSHS", "DSHU", "DSNS", "DSNL", "DSSP", "DVCC", "DVUP", "SCIS"]

pages.each do |page| 
  # Which page to parse
  doc = Nokogiri::HTML(open("https://ntst.umd.edu/soc/gen-ed-courses.html?term=201308&gen-ed-code=#{page}"))

  title = doc.css('span.course-title').map { |e| "#{e.text}" }
  id = doc.css('div.course-id').map { |e| "#{e.text}" }
  credits = doc.css('span.course-min-credits').map { |e| "#{e.text}" }
  description = doc.css('div.approved-course-text').map { |e| "#{e.text}" } 
  # section = doc.css('span.section-id').map { |e| "#{e.text}" }
  # professor = doc.css('span.section-instructor').map { |e| "#{e.text}" }
  
  i = 0
  title.size.times do |x|
	Course.create(department: "#{id[x][0..3]}", course_num: "#{id[x][4..6]}", course_code: "#{id[x]}", name: "#{title[x]}", credits: credits[x].to_i, description: "#{description[x]}") unless Course.find_by_course_code("#{id[x]}")
  end
end

