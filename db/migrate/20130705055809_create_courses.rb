class CreateCourses < ActiveRecord::Migration
  def change
    # Create table to store basic information about each course
    create_table :courses do |t|
      t.string "department" # CMSC
      t.integer "course_num" # 250
      t.string "course_code" # CMSC250
      t.string "name" # Discrete Structures
      t.integer "credits" # 4
      t.text "description" # The main paragraph of text describing the course, including requirements and prereqs, for now
      t.integer "total_seats" # total seats of all sections, added from sections table
      t.integer "open_seats" # total number of open seats from all sections, added from sections table
      t.string "professor" # only the first professor listed
      t.integer "num_professors" # the number of total professors, e.g. "Professors: Clyde Kruskal and 5 others..."
      t.boolean "undergrad", :default => true # whether or not a course is an undergraduate course 
      t.string "gened_codes"
      
      t.timestamps
    end
    add_index("courses","course_code")
 end 
end