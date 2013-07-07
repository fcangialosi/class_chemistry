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
      # t.boolean "perm_req", :default => false # whether or not permission is required to sign up
      #t.text "prereq" # list of prerequisites "Must have math eligiblity of MATH220..."
      #t.text "restriction" # list of any other restrictions required to sign up

      # add gened types
      t.boolean "FSAW", :default => false
      t.boolean "FSAR", :default => false
      t.boolean "FSMA", :default => false
      t.boolean "FSOC", :default => false
      t.boolean "FSPW", :default => false
      t.boolean "DSHS", :default => false
      t.boolean "DSHU", :default => false
      t.boolean "DSNS", :default => false
      t.boolean "DSNL", :default => false
      t.boolean "DSSP", :default => false
      t.boolean "DVCC", :default => false
      t.boolean "DVUP", :default => false
      t.boolean "SCIS", :default => false
      t.boolean "HSorHU", :default => false
      t.boolean "HSorSP", :default => false
      t.boolean "HSorNS", :default => false
      t.boolean "HUorSP", :default => false
      t.boolean "NLorSP", :default => false
      t.boolean "HSorHUorSP", :default => false
      t.boolean "NLorNSorSP", :default => false
      t.timestamps
    end
    add_index("courses","course_code")
 end  

end