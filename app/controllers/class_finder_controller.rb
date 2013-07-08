class ClassFinderController < ApplicationController
  
  def index
  	@courses = []
  	30.times do |x|
  		course = Course.offset(rand(Course.count)).first
  		while(!course.undergrad)
			course = Course.offset(rand(Course.count)).first
  		end
  	  @courses.push(course)
  	end
   
  end

end
