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

ActiveRecord::Schema.define(version: 20130821160943) do

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username"
    t.string   "userid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  add_index "admins", ["userid"], name: "index_admins_on_userid", unique: true, using: :btree

  create_table "content_infos", force: true do |t|
    t.string   "title"
    t.integer  "last_rev",     default: 0
    t.string   "tag"
    t.string   "category"
    t.string   "content_type"
    t.integer  "parent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logs", force: true do |t|
    t.integer  "content_id"
    t.string   "comment"
    t.string   "editor"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.integer  "content_id"
    t.string   "manager"
    t.integer  "total_task",  default: 0
    t.integer  "finish_task", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "raw_files", force: true do |t|
    t.string   "comment"
    t.integer  "content_id",          default: 0
    t.string   "uploader"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "upload_file_name"
    t.string   "upload_content_type"
    t.integer  "upload_file_size"
    t.datetime "upload_updated_at"
  end

  create_table "tasks", force: true do |t|
    t.integer  "content_id"
    t.datetime "s_date"
    t.datetime "e_date"
    t.string   "person"
    t.integer  "total_todo",  default: 0
    t.integer  "finish_todo", default: 0
    t.integer  "state",       default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "to_dos", force: true do |t|
    t.integer  "content_id"
    t.integer  "idx",        default: 0
    t.string   "title"
    t.integer  "state",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username"
    t.string   "userid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["userid"], name: "index_users_on_userid", unique: true, using: :btree

  create_table "wikis", force: true do |t|
    t.integer  "content_id"
    t.integer  "rev",        default: 0
    t.text     "text"
    t.string   "editor"
    t.string   "comment",    default: ""
    t.boolean  "is_last",    default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
