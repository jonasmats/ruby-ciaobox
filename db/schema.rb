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

ActiveRecord::Schema.define(version: 20151125083034) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "uuid-ossp"

  create_table "addresses", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "cap"
    t.string   "address_name"
    t.string   "city"
    t.string   "country"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "addresses", ["user_id"], name: "index_addresses_on_user_id", using: :btree

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
    t.datetime "deleted_at"
    t.string   "username"
    t.string   "type",                                null: false
    t.integer  "status",                 default: 1,  null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  add_index "admins", ["username"], name: "index_admins_on_username", using: :btree

  create_table "article_translations", force: :cascade do |t|
    t.integer  "article_id",  null: false
    t.string   "locale",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "title"
    t.text     "description"
    t.text     "content"
  end

  add_index "article_translations", ["article_id"], name: "index_article_translations_on_article_id", using: :btree
  add_index "article_translations", ["locale"], name: "index_article_translations_on_locale", using: :btree

  create_table "articles", force: :cascade do |t|
    t.integer  "admin_id"
    t.integer  "status",             null: false
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "articles", ["admin_id"], name: "index_articles_on_admin_id", using: :btree

  create_table "banners", force: :cascade do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "status",             null: false
    t.datetime "deleted_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "ciaobox_user_profiles", force: :cascade do |t|
    t.integer  "admin_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "ciaobox_user_profiles", ["admin_id"], name: "index_ciaobox_user_profiles_on_admin_id", using: :btree

  create_table "ciaobox_user_users_roles", force: :cascade do |t|
    t.integer  "admin_id"
    t.integer  "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "ciaobox_user_users_roles", ["admin_id", "role_id"], name: "index_ciaobox_user_users_roles_on_admin_id_and_role_id", using: :btree
  add_index "ciaobox_user_users_roles", ["admin_id"], name: "index_ciaobox_user_users_roles_on_admin_id", using: :btree
  add_index "ciaobox_user_users_roles", ["role_id"], name: "index_ciaobox_user_users_roles_on_role_id", using: :btree

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "date_offs", force: :cascade do |t|
    t.date     "start_at",     null: false
    t.date     "end_at",       null: false
    t.integer  "subject_id"
    t.string   "subject_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "drivers", force: :cascade do |t|
    t.string   "code",       null: false
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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

  create_table "feedbacks", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "order_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "feedbacks", ["order_id"], name: "index_feedbacks_on_order_id", using: :btree
  add_index "feedbacks", ["user_id"], name: "index_feedbacks_on_user_id", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "item_pictures", force: :cascade do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "item_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "items", force: :cascade do |t|
    t.string   "type",       null: false
    t.hstore   "data",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "log_actions", force: :cascade do |t|
    t.integer  "owner_id"
    t.string   "action_type"
    t.integer  "subject_id"
    t.string   "subject_type"
    t.hstore   "data"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "newsletters", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "newsletters", ["email"], name: "index_newsletters_on_email", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.hstore   "info",       default: {}, null: false
    t.integer  "status",     default: 0,  null: false
    t.string   "type"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "order_detail_images", force: :cascade do |t|
    t.integer  "order_item_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "order_detail_images", ["order_item_id"], name: "index_order_detail_images_on_order_item_id", using: :btree

  create_table "order_details", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "order_item_id"
    t.float    "price",         null: false
    t.integer  "quantity",      null: false
    t.string   "barcode",       null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "order_details", ["barcode"], name: "index_order_details_on_barcode", using: :btree
  add_index "order_details", ["order_id"], name: "index_order_details_on_order_id", using: :btree
  add_index "order_details", ["order_item_id"], name: "index_order_details_on_order_item_id", using: :btree

  create_table "order_item_translations", force: :cascade do |t|
    t.integer  "order_item_id", null: false
    t.string   "locale",        null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "title"
    t.text     "description"
  end

  add_index "order_item_translations", ["locale"], name: "index_order_item_translations_on_locale", using: :btree
  add_index "order_item_translations", ["order_item_id"], name: "index_order_item_translations_on_order_item_id", using: :btree

  create_table "order_items", force: :cascade do |t|
    t.float    "price"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "type"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "shipping_id"
    t.integer  "pay_status",                      null: false
    t.string   "shipping_date",                   null: false
    t.string   "shipping_time",                   null: false
    t.datetime "start_date_keep"
    t.datetime "end_date_keep"
    t.float    "amount"
    t.string   "address"
    t.string   "state"
    t.text     "additional"
    t.string   "contact_name"
    t.string   "contact_email"
    t.string   "contact_phone"
    t.boolean  "save_image",      default: false, null: false
    t.integer  "status",          default: 0
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "orders", ["shipping_id"], name: "index_orders_on_shipping_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "payment_infors", force: :cascade do |t|
    t.integer  "owner_id",          null: false
    t.string   "owner_type",        null: false
    t.integer  "payment_method_id", null: false
    t.hstore   "infors",            null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "payment_infors", ["owner_id", "owner_type", "payment_method_id"], name: "index_for_payment_infors", using: :btree

  create_table "payment_methods", force: :cascade do |t|
    t.integer  "payment_type"
    t.string   "name"
    t.datetime "deleted_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "payment_methods", ["payment_type", "name"], name: "index_payment_methods_on_payment_type_and_name", unique: true, using: :btree

  create_table "permissions", force: :cascade do |t|
    t.integer  "role_id",    null: false
    t.string   "entity",     null: false
    t.hstore   "settings"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "permissions", ["entity"], name: "index_permissions_on_entity", using: :btree
  add_index "permissions", ["role_id", "entity"], name: "index_permissions_on_role_id_and_entity", unique: true, using: :btree
  add_index "permissions", ["role_id"], name: "index_permissions_on_role_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name"], name: "index_roles_on_name", unique: true, using: :btree

  create_table "shippings", force: :cascade do |t|
    t.string   "zip_code",               null: false
    t.integer  "way",        default: 0, null: false
    t.integer  "driver_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "shippings", ["driver_id"], name: "index_shippings_on_driver_id", using: :btree

  create_table "slot_schedules", force: :cascade do |t|
    t.integer  "slot_time_id", null: false
    t.integer  "driver_id",    null: false
    t.integer  "limit",        null: false
    t.integer  "slot_date",    null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "slot_schedules", ["driver_id"], name: "index_slot_schedules_on_driver_id", using: :btree
  add_index "slot_schedules", ["slot_time_id"], name: "index_slot_schedules_on_slot_time_id", using: :btree

  create_table "slot_times", force: :cascade do |t|
    t.string   "start_at",   null: false
    t.string   "end_at",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "social_networks", force: :cascade do |t|
    t.string   "name"
    t.string   "link"
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
    t.datetime "deleted_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "static_page_translations", force: :cascade do |t|
    t.integer  "static_page_id", null: false
    t.string   "locale",         null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.text     "content"
  end

  add_index "static_page_translations", ["locale"], name: "index_static_page_translations_on_locale", using: :btree
  add_index "static_page_translations", ["static_page_id"], name: "index_static_page_translations_on_static_page_id", using: :btree

  create_table "static_pages", force: :cascade do |t|
    t.string   "title",      null: false
    t.string   "slug",       null: false
    t.integer  "status",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "static_pages", ["slug"], name: "index_static_pages_on_slug", unique: true, using: :btree

  create_table "user_profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "telephone"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "user_profiles", ["user_id"], name: "index_user_profiles_on_user_id", using: :btree

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
    t.hstore   "note"
    t.datetime "deleted_at"
    t.string   "username"
    t.integer  "status",                 default: 1,  null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", using: :btree

  add_foreign_key "addresses", "users"
  add_foreign_key "articles", "admins"
  add_foreign_key "ciaobox_user_profiles", "admins"
  add_foreign_key "ciaobox_user_users_roles", "admins"
  add_foreign_key "ciaobox_user_users_roles", "roles"
  add_foreign_key "faqs", "faq_categories"
  add_foreign_key "feedbacks", "orders"
  add_foreign_key "feedbacks", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "order_detail_images", "order_items"
  add_foreign_key "order_details", "order_items"
  add_foreign_key "order_details", "orders"
  add_foreign_key "orders", "shippings"
  add_foreign_key "orders", "users"
  add_foreign_key "payment_infors", "payment_methods"
  add_foreign_key "permissions", "roles"
  add_foreign_key "shippings", "drivers"
  add_foreign_key "slot_schedules", "drivers"
  add_foreign_key "slot_schedules", "slot_times"
  add_foreign_key "user_profiles", "users"
end
