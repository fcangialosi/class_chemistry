class CreateOurumds < ActiveRecord::Migration
  def change
   # Create and index table relating all the "overall" OurUMD data to each course
    create_table :ourumds do |t|
  	  t.string "course_code" # relation to course
  	  t.text "graph_url" # way to access the image for the bar graph visualizing percentage data
      t.float "gpa" # overall GPA

      t.integer "perc_a_plus" # percentage of A+'s overall
      t.integer "perc_a"
      t.integer "perc_a_minus"
      t.integer "perc_b_plus"
      t.integer "perc_b"
      t.integer "perc_b_minus"
      t.integer "perc_c_plus"
      t.integer "perc_c"
      t.integer "perc_c_minus"
      t.integer "perc_d_plus"
      t.integer "perc_d"
      t.integer "perc_d_minus"
      t.integer "perc_f"
      t.integer "perc_drop"
 

      t.integer "num_students" # number of students that these records apply for 
      t.integer "num_sections" 
      t.integer "num_semesters" 
      t.timestamps
    end
    add_index("ourumds","course_code")
  end
end
