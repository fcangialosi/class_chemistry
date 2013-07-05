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

ActiveRecord::Schema.define(:version => 20130705063400) do

  create_table "courses", :force => true do |t|
    t.string   "department"
    t.integer  "course_num"
    t.string   "course_code"
    t.string   "name"
    t.integer  "credits"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "courses", ["course_code"], :name => "index_courses_on_course_code"

  create_table "genedtypes", :force => true do |t|
    t.integer  "course_id"
    t.boolean  "fsaw",       :default => false
    t.boolean  "fsar",       :default => false
    t.boolean  "fsma",       :default => false
    t.boolean  "fsoc",       :default => false
    t.boolean  "fspw",       :default => false
    t.boolean  "dshs",       :default => false
    t.boolean  "dshu",       :default => false
    t.boolean  "dsns",       :default => false
    t.boolean  "dsnl",       :default => false
    t.boolean  "dssp",       :default => false
    t.boolean  "dvcc",       :default => false
    t.boolean  "dvup",       :default => false
    t.boolean  "scis",       :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "genedtypes", ["course_id"], :name => "index_genedtypes_on_course_id"

  create_table "ourumddata", :force => true do |t|
    t.integer  "course_id"
    t.text     "graph_url"
    t.float    "gpa"
    t.integer  "perc_a"
    t.integer  "perc_b"
    t.integer  "perc_c"
    t.integer  "perc_d"
    t.integer  "perc_f"
    t.integer  "num_students"
    t.integer  "num_sections"
    t.integer  "num_semesters"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "ourumddata", ["course_id"], :name => "index_ourumddata_on_course_id"

  create_table "sections", :force => true do |t|
    t.integer  "course_id"
    t.integer  "section_num"
    t.string   "professor"
    t.integer  "seats_total"
    t.integer  "seats_open"
    t.integer  "seats_waitlist"
    t.string   "lecture_building"
    t.integer  "lecture_room"
    t.string   "lecture_times"
    t.string   "discussion_building"
    t.integer  "discussion_room"
    t.string   "discussion_times"
    t.boolean  "freshman_connection", :default => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "sections", ["course_id"], :name => "index_sections_on_course_id"

end
