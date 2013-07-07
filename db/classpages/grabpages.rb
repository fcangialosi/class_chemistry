require 'watir-webdriver'
require 'nokogiri'
require 'open-uri'

def strip(str) if(str != nil) then return str.delete("\n").delete("\t").delete("\r") end end

browser = Watir::Browser.new :ff


doc = Nokogiri::HTML(open("https://ntst.umd.edu/soc/index.html?term=201308")) # Open department listing page
departments = doc.css("span.prefix-abbrev").map {|e| "#{strip(e.text)}"} # Get a list of all department pages 
departments.push("FSAW", "FSAR", "FSMA", "FSOC", "FSPW", "DSHS", "DSHU", "DSNS", "DSNL", "DSSP", "DVCC", "DVUP", "SCIS") # Add the GenEd pages
failed_list = ""

departments.each do |page|
  
  puts "Opening #{page} page..."
  browser.goto "https://ntst.umd.edu/soc/courses.html?term=201308&prefix=#{page}"
  browser.button(:value => "Show All Sections").click
  puts "Loading sections..."
  sleep(2)

  begin 
	browser.div(:class => "sections-container").click # Make sure sections have loaded
	puts "Downloading HTML file..."
    file = File.open("#{page}.html", 'w')
    file.puts browser.html
    file.close
    puts "=====File downloaded!====="
  rescue Exception
  	puts "Unable to find sections for #{page}! Try sleeping for longer."
  	failed_list << "\n#{page}"
  end
end
  	
if failed_list.empty?
	puts "NOICE, no fails! All pages were loaded successfully. You're good to go."
else
	puts "Fishpaste! The following pages were not able to be downloaded...#{failed_list}"
end
browser.close


