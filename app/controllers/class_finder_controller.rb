class ClassFinderController < ApplicationController
  
  def index
  	@courses = []
  	10.times do |x|
  	  @courses.push(Course.offset(rand(Course.count)).first)
  	end
   
  end

end
