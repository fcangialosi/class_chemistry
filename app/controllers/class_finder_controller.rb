class ClassFinderController < ApplicationController
  
   def index
  	@courses = Course.limit(20)
  end

end
