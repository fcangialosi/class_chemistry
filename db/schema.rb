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
    t.boolean  "FSAW",        :default => false
    t.boolean  "FSAR",        :default => false
    t.boolean  "FSMA",        :default => false
    t.boolean  "FSOC",        :default => false
    t.boolean  "FSPW",        :default => false
    t.boolean  "DSHS",        :default => false
    t.boolean  "DSHU",        :default => false
    t.boolean  "DSNS",        :default => false
    t.boolean  "DSNL",        :default => false
    t.boolean  "DSSP",        :default => false
    t.boolean  "DVCC",        :default => false
    t.boolean  "DVUP",        :default => false
    t.boolean  "SCIS",        :default => false
    t.boolean  "HSorHU",      :default => false
    t.boolean  "HSorSP",      :default => false
    t.boolean  "HSorNS",      :default => false
    t.boolean  "HUorSP",      :default => false
    t.boolean  "NLorSP",      :default => false
    t.boolean  "HSorHUorSP",  :default => false
    t.boolean  "NLorNSorSP",  :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "courses", ["course_code"], :name => "index_courses_on_course_code"

  create_table "ourumds", :force => true do |t|
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

  add_index "ourumds", ["course_id"], :name => "index_ourumds_on_course_id"

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
