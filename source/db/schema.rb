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

ActiveRecord::Schema.define(version: 20151028082520) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "type"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "ciaobox_user_profiles", force: :cascade do |t|
    t.integer  "admin_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "ciaobox_user_profiles", ["admin_id"], name: "index_ciaobox_user_profiles_on_admin_id", using: :btree

  create_table "faq_categories", force: :cascade do |t|
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "faq_category_translations", force: :cascade do |t|
    t.integer  "faq_category_id", null: false
    t.string   "locale",          null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "name"
  end

  add_index "faq_category_translations", ["faq_category_id"], name: "index_faq_category_translations_on_faq_category_id", using: :btree
  add_index "faq_category_translations", ["locale"], name: "index_faq_category_translations_on_locale", using: :btree

  create_table "faq_translations", force: :cascade do |t|
    t.integer  "faq_id",     null: false
    t.string   "locale",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "question"
    t.text     "answer"
  end

  add_index "faq_translations", ["faq_id"], name: "index_faq_translations_on_faq_id", using: :btree
  add_index "faq_translations", ["locale"], name: "index_faq_translations_on_locale", using: :btree

  create_table "faqs", force: :cascade do |t|
    t.integer  "faq_category_id"
    t.datetime "deleted_at"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "faqs", ["faq_category_id"], name: "index_faqs_on_faq_category_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "ciaobox_user_profiles", "admins"
  add_foreign_key "faqs", "faq_categories"
end
