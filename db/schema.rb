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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140809163722) do

  create_table "Phonebook_SourceData", id: false, force: true do |t|
    t.integer "LBSNO",                     null: false
    t.string  "Surname",        limit: 30
    t.string  "Knownname",      limit: 30
    t.string  "UID",            limit: 50, null: false
    t.string  "Dptcode",        limit: 10
    t.string  "Department"
    t.string  "PhoneExtension", limit: 10
    t.string  "Room",           limit: 20
  end

  create_table "SchDBtoPhonebook_SourceData", id: false, force: true do |t|
    t.integer "LBSNO",                null: false
    t.string  "Surname",   limit: 30
    t.string  "Knownname", limit: 30
    t.string  "UID",       limit: 50, null: false
  end

  create_table "activity_logs", force: true do |t|
    t.string   "item_type"
    t.integer  "item_id"
    t.string   "act_action"
    t.string   "updated_by"
    t.text     "activity"
    t.datetime "act_tstamp"
  end

  create_table "archiving_policies", force: true do |t|
    t.string   "name",                       default: "Global", null: false
    t.text     "description"
    t.integer  "policy_type_id",   limit: 2, default: 7,        null: false
    t.string   "lync_policy_name",           default: "Global", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "building_floors", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "buildings", force: true do |t|
    t.string   "name",       limit: 32, default: "LBS building", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name",       limit: 50, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_policies", force: true do |t|
    t.string   "name",                       default: "Global", null: false
    t.text     "description"
    t.integer  "policy_type_id",   limit: 2, default: 11,       null: false
    t.string   "lync_policy_name",           default: "Global", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_version_policies", force: true do |t|
    t.string   "name",                       default: "Global", null: false
    t.text     "description"
    t.integer  "policy_type_id",   limit: 2, default: 4,        null: false
    t.string   "lync_policy_name",           default: "Global", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conference_policies", force: true do |t|
    t.string   "name",                       default: "Global", null: false
    t.text     "description"
    t.integer  "policy_type_id",   limit: 2, default: 3,        null: false
    t.string   "lync_policy_name",           default: "Global", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", force: true do |t|
    t.string   "name",            limit: 50,                null: false
    t.integer  "category_id",                default: 1,    null: false
    t.string   "department_code", limit: 4,  default: "00"
    t.integer  "active",          limit: 1,  default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments_extension_ranges", id: false, force: true do |t|
    t.integer "department_id",      null: false
    t.integer "extension_range_id", null: false
  end

  create_table "dial_plan_policies", force: true do |t|
    t.string   "name",                       default: "Global", null: false
    t.text     "description"
    t.integer  "policy_type_id",   limit: 2, default: 1,        null: false
    t.string   "lync_policy_name",           default: "Global", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "extension_ranges", force: true do |t|
    t.integer  "first_extension", null: false
    t.integer  "last_extension",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "extensions", force: true do |t|
    t.string   "extension",  limit: 10, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "external_access_policies", force: true do |t|
    t.string   "name",                       default: "Global", null: false
    t.text     "description"
    t.integer  "policy_type_id",   limit: 2, default: 6,        null: false
    t.string   "lync_policy_name",           default: "Global", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "location_policies", force: true do |t|
    t.string   "name",                       default: "Global", null: false
    t.text     "description"
    t.integer  "policy_type_id",   limit: 2, default: 8,        null: false
    t.string   "lync_policy_name",           default: "Global", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mobility_policies", force: true do |t|
    t.string   "name",                       default: "Global", null: false
    t.text     "description"
    t.integer  "policy_type_id",   limit: 2, default: 9,        null: false
    t.string   "lync_policy_name",           default: "Global", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "persist_chat_policies", force: true do |t|
    t.string   "name",                       default: "Global", null: false
    t.text     "description"
    t.integer  "policy_type_id",   limit: 2, default: 10,       null: false
    t.string   "lync_policy_name",           default: "Global", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phonebook_sessions", force: true do |t|
    t.string   "session_id",             null: false
    t.text     "phonebook_session_data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "phonebook_sessions", ["session_id"], name: "index_phonebook_sessions_on_session_id", unique: true
  add_index "phonebook_sessions", ["updated_at"], name: "index_phonebook_sessions_on_updated_at"

  create_table "phones", force: true do |t|
    t.string   "firstname",                 limit: 32, default: "Firstname", null: false
    t.string   "surname",                   limit: 32, default: "Surname",   null: false
    t.string   "uid",                       limit: 32,                       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sub_department_id",         limit: 2
    t.integer  "extension_id",              limit: 2
    t.integer  "room_id",                   limit: 2
    t.integer  "dial_plan_policy_id",       limit: 2,  default: 1,           null: false
    t.integer  "voice_policy_id",           limit: 2,  default: 1,           null: false
    t.integer  "conferencing_policy_id",    limit: 2,  default: 1,           null: false
    t.integer  "external_access_policy_id", limit: 2,  default: 1,           null: false
    t.integer  "archiving_policy_id",       limit: 2,  default: 1,           null: false
    t.integer  "client_version_policy_id",  limit: 2,  default: 1,           null: false
    t.integer  "pin_policy_id",             limit: 2,  default: 1,           null: false
    t.integer  "location_policy_id",        limit: 2,  default: 1,           null: false
    t.integer  "mobility_policy_id",        limit: 2,  default: 1,           null: false
    t.integer  "persist_chat_policy_id",    limit: 2,  default: 1,           null: false
    t.integer  "client_policy_id",          limit: 2,  default: 1,           null: false
  end

  create_table "pin_policies", force: true do |t|
    t.string   "name",                       default: "Global", null: false
    t.text     "description"
    t.integer  "policy_type_id",   limit: 2, default: 5,        null: false
    t.string   "lync_policy_name",           default: "Global", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "policy_types", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "room_statuses", force: true do |t|
    t.string   "name",       limit: 16, default: "Public", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rooms", force: true do |t|
    t.string   "name",              limit: 32, default: "LBS room",         null: false
    t.string   "public_name",       limit: 32, default: "Public room name", null: false
    t.integer  "room_status_id",    limit: 2,  default: 1,                  null: false
    t.integer  "building_id",       limit: 2,                               null: false
    t.integer  "building_floor_id", limit: 2,  default: 1,                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rooms_backup", id: false, force: true do |t|
    t.integer  "id",                limit: 2,  null: false
    t.string   "name",              limit: 32, null: false
    t.string   "public_name",       limit: 32, null: false
    t.integer  "room_status_id",    limit: 2,  null: false
    t.integer  "building_id",       limit: 2,  null: false
    t.integer  "building_floor_id", limit: 2,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sub_departments", force: true do |t|
    t.string   "name",                         limit: 50,                null: false
    t.string   "sub_department_code",          limit: 4,  default: "00"
    t.integer  "department_id"
    t.integer  "preferred_extension_range_id"
    t.integer  "active",                       limit: 1,  default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dial_plan_policy_id",          limit: 2,  default: 1,    null: false
    t.integer  "voice_policy_id",              limit: 2,  default: 1,    null: false
    t.integer  "conferencing_policy_id",       limit: 2,  default: 1,    null: false
    t.integer  "external_access_policy_id",    limit: 2,  default: 1,    null: false
    t.integer  "archiving_policy_id",          limit: 2,  default: 1,    null: false
    t.integer  "client_version_policy_id",     limit: 2,  default: 1,    null: false
    t.integer  "pin_policy_id",                limit: 2,  default: 1,    null: false
    t.integer  "location_policy_id",           limit: 2,  default: 1,    null: false
    t.integer  "mobility_policy_id",           limit: 2,  default: 1,    null: false
    t.integer  "persist_chat_policy_id",       limit: 2,  default: 1,    null: false
    t.integer  "client_policy_id",             limit: 2,  default: 1,    null: false
  end

  create_table "users", force: true do |t|
    t.string   "username",                        null: false
    t.integer  "sign_in_count",       default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "remember_created_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  create_table "voice_policies", force: true do |t|
    t.string   "name",                       default: "Global", null: false
    t.text     "description"
    t.integer  "policy_type_id",   limit: 2, default: 2,        null: false
    t.string   "lync_policy_name",           default: "Global", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
