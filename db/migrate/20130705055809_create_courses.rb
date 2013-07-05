class CreateCourses < ActiveRecord::Migration

  def change
    # Create table to store basic information about each course
    create_table :courses do |t|
      t.string "department" # CMSC
      t.integer "course_num" # 250
      t.string "course_code" # CMSC250
      t.string "name" # Discrete Structures
      t.integer "credits" # 4
      t.string "professor" # Clyde Kruskal, Tom Reinhardt (limit to first 2?)
      t.text "description" # The main paragraph of text describing the course, not anything about requirements or other offerings
      # seat information stored in sections database for now...
      t.boolean "perm_req", :default => false # whether or not permission is required to sign up
      t.text "prereq" # list of prerequisites "Must have math eligiblity of MATH220..."
      t.text "restriction" # list of any other restrictions required to sign up
      t.timestamps
    end
    add_index("courses","course_code")

    # Create and index table relating Gen Ed codes to each course
    create_table :genedtypes do |t|
      t.integer "course_id" # relation to course
      t.boolean "fsaw", :default => false
      t.boolean "fsar", :default => false
      t.boolean "fsma", :default => false
      t.boolean "fsoc", :default => false
      t.boolean "fspw", :default => false
      t.boolean "dshs", :default => false
      t.boolean "dshu", :default => false
      t.boolean "dsns", :default => false
      t.boolean "dsnl", :default => false
	  t.boolean "dssp", :default => false
	  t.boolean "dvcc", :default => false
	  t.boolean "dvup", :default => false
	  t.boolean "scis", :default => false
	  t.timestamps
    end
    add_index("genedtypes","course_id")

  # Create and index table relating all the "overall" OurUMD data to each course
    create_table :ourumddata do |t|
  	  t.integer "course_id" # relation to course
  	  t.text "graph_url" # way to access the image for the bar graph visualizing percentage data
      t.float "gpa" # overall GPA
      t.integer "perc_a" # percentage of A's overall
      t.integer "perc_b"
      t.integer "perc_c"
      t.integer "perc_d"
      t.integer "perc_f"
      t.integer "num_students" # number of students that these records apply for 
      t.integer "num_sections" 
      t.integer "num_semesters" 
      t.timestamps
    end
    add_index("ourumddata","course_id")
 end  

end