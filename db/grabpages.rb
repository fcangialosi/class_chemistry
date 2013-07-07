require 'watir-webdriver'
require 'nokogiri'
require 'open-uri'

def strip(str) if(str != nil) then return str.delete("\n").delete("\t").delete("\r") end end

browser = Watir::Browser.new :ff


doc = Nokogiri::HTML(open("https://ntst.umd.edu/soc/index.html?term=201308")) # Open department listing page
departments = doc.css("span.prefix-abbrev").map {|e| "#{strip(e.text)}"} # Get a list of all department pages 
departments.push("FSAW", "FSAR", "FSMA", "FSOC", "FSPW", "DSHS", "DSHU", "DSNS", "DSNL", "DSSP", "DVCC", "DVUP", "SCIS") # Add the GenEd pages

gened = ["FSAW", "FSAR", "FSMA", "FSOC", "FSPW", "DSHS", "DSHU", "DSNS", "DSNL", "DSSP", "DVCC", "DVUP", "SCIS"]
no_sections = ["BISI", "ENBE", "IVSP", "MAIT", "MUSP", "SLAV"]
empty_list = ["EMBA", "MAIT", "NIAP", "NIAS"]
failed_list = ""

departments.each do |page|
  
  if(empty_list.include?(page)) # Skip it if it's known to be empty
    next
  end
  if(File.exists?("./classpages/#{page}.html")) # If the file already exists, skip it, comment out to update files
    next
  end

  puts "Opening #{page} page..."
  if(gened.include?(page)) # If it's a gened, must modify URL slightly to identify as such
    browser.goto "https://ntst.umd.edu/soc/gen-ed-courses.html?term=201308&gen-ed-code=#{page}"
  else
    browser.goto "https://ntst.umd.edu/soc/courses.html?term=201308&prefix=#{page}"
  end
  
  begin 
  	browser.button(:value => "Show All Sections").click # Expose sections
    if(!no_sections.include?(page)) # Only skip this if the page is listed as not containing information about sections
      puts "Loading sections..."
      sleep(2) # Wait for them to load
	    browser.div(:class => "sections-container").click # Make sure sections have loaded
    end
	  puts "Downloading HTML file..."
    file = File.open("./classpages/#{page}.html", 'w')
    file.puts browser.html
    file.close
    puts "=====File downloaded!====="
    next # If no exception was thrown, then skip to the next iteration because the file has already been downloaded
  rescue Exception
  end

  # only reached if the first try failed, wait longer and try again
  begin
    sleep(5) # Wait for them to load
    browser.div(:class => "sections-container").click # Make sure sections have loaded
    puts "Downloading HTML file..."
    file = File.open("./classpages/#{page}.html", 'w')
    file.puts browser.html
    file.close
    puts "=====File downloaded!====="
  rescue # if it failed the second time, skip it for now, and keep track of which ones failed
    puts "Unable to load sections for #{page}! Either the page is empty or you need to sleep longer."
    failed_list << "\n#{page}"
  end 
end
  	
if failed_list.empty?
	puts "NOICE, no fails! All pages were loaded successfully. You're good to go."
else
	puts "Fishpaste! The following pages were not able to be downloaded...#{failed_list}"
end
browser.close