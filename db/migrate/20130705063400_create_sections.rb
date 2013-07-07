class CreateSections < ActiveRecord::Migration
  
  def change
    create_table :sections do |t|
      t.integer "course_id" # primary key in courses DB
      t.integer "section_num" # 0101 
      t.string "professor"
      t.integer "seats_total"
      t.integer "seats_open"
      t.integer "seats_waitlist"

      # information about the class' lecture class
      t.string "lecture_days"
      t.time "lecture_start"
      t.time "lecture_end"
      t.string "lecture_building"
      t.integer "lecture_room"
      

      t.boolean "has_discussion", :default => false
      # information about the class' discussion section
      t.string "disc_days"
      t.time "disc_start"
      t.time "disc_end"
      t.string "disc_building"
      t.integer "disc_room"

      t.boolean "freshman_connection", :default => false # whether or not the section is only offered to students in freshman connection
      t.boolean "sci_evening", :default => false # whether or not the the section is only offered to students in science in the evening

      t.timestamps
    end
    add_index("sections", "course_id")

  end
end
