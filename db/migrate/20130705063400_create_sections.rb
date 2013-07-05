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
      t.string "lecture_building"
      t.integer "lecture_room"
      t.string "lecture_times"

      # information about the class' discussion section
      t.string "discussion_building"
      t.integer "discussion_room"
      t.string "discussion_times" 

      t.boolean "freshman_connection", :default => false # whether or not the section is only offered to students in FC

      t.timestamps
    end
    add_index("sections", "course_id")

  end
end
