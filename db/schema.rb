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

ActiveRecord::Schema.define(:version => 20121226081149) do

  create_table "car_registers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "car_id"
    t.string   "apply_reason"
    t.datetime "begin_time"
    t.datetime "end_time"
    t.string   "check_notes"
    t.string   "notes",        :limit => 1000
    t.integer  "checked_by"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "car_registers", ["car_id"], :name => "index_car_registers_on_car_id"
  add_index "car_registers", ["user_id"], :name => "index_car_registers_on_user_id"

  create_table "cars", :force => true do |t|
    t.string   "name"
    t.string   "license"
    t.datetime "buy_time"
    t.datetime "last_check_time"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "cars", ["created_by"], :name => "index_cars_on_created_by"
  add_index "cars", ["updated_by"], :name => "index_cars_on_updated_by"

  create_table "emp_msgs", :force => true do |t|
    t.integer  "from_id"
    t.integer  "to_id"
    t.string   "to_names",   :limit => 1000
    t.string   "title",      :limit => 1000
    t.string   "content",    :limit => 3000
    t.integer  "viewed",     :limit => 2
    t.string   "url",        :limit => 1000
    t.datetime "created_at"
    t.integer  "folder_id"
  end

  add_index "emp_msgs", ["from_id"], :name => "emp_msg_form_id"
  add_index "emp_msgs", ["to_id"], :name => "emp_msg_to_id"
  add_index "emp_msgs", ["viewed"], :name => "emp_msg_viewed"

  create_table "messages", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "company"
    t.string   "message"
    t.integer  "status_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "messages", ["status_id"], :name => "index_messages_on_status_id"

  create_table "projects", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "description",   :limit => 2000
    t.date     "project_date"
    t.string   "tech_info",     :limit => 2000
    t.string   "system_config", :limit => 3000
    t.string   "notes",         :limit => 2000
    t.string   "index_pic"
    t.string   "pic_path"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "created_by"
    t.integer  "updated_by"
  end

  add_index "projects", ["created_by"], :name => "index_projects_on_created_by"
  add_index "projects", ["updated_by"], :name => "index_projects_on_updated_by"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "user_sessions", :force => true do |t|
    t.string   "session_id",               :default => "", :null => false
    t.string   "username",   :limit => 45, :default => "", :null => false
    t.integer  "user_id",                                  :null => false
    t.integer  "last",                     :default => 0,  :null => false
    t.string   "ip",         :limit => 20
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  add_index "user_sessions", ["session_id"], :name => "user_session_sid"
  add_index "user_sessions", ["user_id", "last"], :name => "user_session_user_id"
  add_index "user_sessions", ["username"], :name => "user_session_username"

  create_table "users", :force => true do |t|
    t.string   "username",        :limit => 100
    t.string   "name_cn",         :limit => 100
    t.string   "hashed_password"
    t.string   "salt"
    t.integer  "active",          :limit => 2
    t.integer  "department_id"
    t.string   "email"
    t.string   "phone",           :limit => 50
    t.string   "phone_ext",       :limit => 50
    t.string   "mobile",          :limit => 50
    t.string   "fax",             :limit => 50
    t.string   "encode"
    t.datetime "join_date"
    t.datetime "leave_date"
    t.datetime "leave_reason"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "users", ["active"], :name => "idx_emp_active"

end
