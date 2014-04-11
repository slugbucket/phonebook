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

ActiveRecord::Schema.define(version: 18) do

  create_table "activity_logs", force: true do |t|
    t.string   "item_type",  limit: 64, default: "Object",              null: false
    t.integer  "item_id",                                               null: false
    t.string   "act_action",            default: "update"
    t.string   "updated_by", limit: 32, default: "Anonymous"
    t.text     "activity"
    t.datetime "act_tstamp",            default: '2014-01-25 16:57:31'
  end

  create_table "building_floors", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "buildings", force: true do |t|
    t.string   "name",       limit: 32, default: "Building", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name",       limit: 10, default: "Staff", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", force: true do |t|
    t.string   "name",                      limit: 32,                null: false
    t.integer  "category_id",               limit: 1,                 null: false
    t.boolean  "active",                               default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "department_code",           limit: 4,  default: "00", null: false
    t.integer  "default_dialling_right_id",            default: 1
  end

  create_table "departments_extension_ranges", id: false, force: true do |t|
    t.integer "department_id",      null: false
    t.integer "extension_range_id", null: false
  end

  create_table "dialling_rights", force: true do |t|
    t.string   "name",        limit: 32, null: false
    t.text     "description"
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
    t.integer  "extension",  limit: 8, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phones", force: true do |t|
    t.string   "firstname",         limit: 32, null: false
    t.string   "surname",           limit: 32, null: false
    t.string   "uid",               limit: 32, null: false
    t.integer  "sub_department_id", limit: 1
    t.integer  "extension_id"
    t.integer  "room_id"
    t.integer  "dialling_right_id", limit: 1
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

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "room_statuses", force: true do |t|
    t.string   "name",       limit: 16, default: "Public", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rooms", force: true do |t|
    t.string   "name",              limit: 32, default: "room",         null: false
    t.string   "public_name",       limit: 32, default: "Public room name", null: false
    t.integer  "room_status_id",               default: 1,                  null: false
    t.integer  "building_id",                                               null: false
    t.integer  "building_floor_id",            default: 1,                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sub_department_extension_range_view", id: false, force: true do |t|
    t.integer "sub_department_id",             default: 0, null: false
    t.string  "sub_department",     limit: 64,             null: false
    t.integer "department_id",                 default: 0, null: false
    t.string  "department",         limit: 32,             null: false
    t.integer "extension_range_id", limit: 8,  default: 0, null: false
    t.integer "first_extension",                           null: false
    t.integer "last_extension",                            null: false
  end

  create_table "sub_departments", force: true do |t|
    t.string   "name",                         limit: 64,                null: false
    t.integer  "department_id",                limit: 2,                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sub_department_code",          limit: 4,  default: "00", null: false
    t.integer  "preferred_extension_range_id"
  end

  create_table "users", force: true do |t|
    t.string   "username",                        null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
