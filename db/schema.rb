# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130706151303) do

  create_table "courses", :force => true do |t|
    t.string   "department"
    t.integer  "course_num"
    t.string   "course_code"
    t.string   "name"
    t.integer  "credits"
    t.text     "description"
    t.integer  "total_seats"
    t.integer  "open_seats"
    t.string   "professor"
    t.integer  "num_professors"
    t.boolean  "undergrad",      :default => true
    t.string   "gened_codes"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "courses", ["course_code"], :name => "index_courses_on_course_code"

  create_table "ourumds", :force => true do |t|
    t.string   "course_code"
    t.text     "graph_url"
    t.float    "gpa"
    t.integer  "perc_a_plus"
    t.integer  "perc_a"
    t.integer  "perc_a_minus"
    t.integer  "perc_b_plus"
    t.integer  "perc_b"
    t.integer  "perc_b_minus"
    t.integer  "perc_c_plus"
    t.integer  "perc_c"
    t.integer  "perc_c_minus"
    t.integer  "perc_d_plus"
    t.integer  "perc_d"
    t.integer  "perc_d_minus"
    t.integer  "perc_f"
    t.integer  "perc_drop"
    t.integer  "num_students"
    t.integer  "num_sections"
    t.integer  "num_semesters"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "ourumds", ["course_code"], :name => "index_ourumds_on_course_code"

  create_table "sections", :force => true do |t|
    t.string   "identifier"
    t.string   "course_code"
    t.string   "section_num"
    t.string   "professor"
    t.integer  "seats_total"
    t.integer  "seats_open"
    t.integer  "seats_waitlist"
    t.string   "lecture_days"
    t.time     "lecture_start"
    t.time     "lecture_end"
    t.string   "lecture_building"
    t.integer  "lecture_room"
    t.boolean  "has_discussion",      :default => false
    t.string   "disc_days"
    t.time     "disc_start"
    t.time     "disc_end"
    t.string   "disc_building"
    t.integer  "disc_room"
    t.boolean  "freshman_connection", :default => false
    t.boolean  "sci_evening",         :default => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "sections", ["course_code"], :name => "index_sections_on_course_code"
  add_index "sections", ["identifier"], :name => "index_sections_on_identifier"

end
