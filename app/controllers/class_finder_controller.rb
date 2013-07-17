class ClassFinderController < ApplicationController
  
  def index
  	@courses = []
  	50.times do |x|
  		course = Course.offset(rand(Course.count)).first
  		while(!course.undergrad)
			course = Course.offset(rand(Course.count)).first
  		end
  	  @courses.push(course)
  	end

    @types = []
    50.times do |x|
      num = Random.rand(1..(6+1))
      case num
        when 1 then @types.push("element alkali metal")
        when 2 then @types.push("element alkaline-earth metal")
        when 3 then @types.push("element halogen nonmetal")
        when 4 then @types.push("element metalloid")
        when 5 then @types.push("element transition metal")
        else @types.push("element noble-gas nonmetal")
      end
    end
  end

end
