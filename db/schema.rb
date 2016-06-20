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

ActiveRecord::Schema.define(version: 20160620201154) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.integer  "resource_id",   limit: 4,     null: false
    t.string   "resource_type", limit: 255,   null: false
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.text     "body",          limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "namespace",     limit: 255
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_admin_notes_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 128, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "armies", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  create_table "army_list_unit_troops", force: :cascade do |t|
    t.integer "army_list_unit_id", limit: 4, null: false
    t.integer "troop_id",          limit: 4, null: false
    t.integer "size",              limit: 4
    t.integer "position",          limit: 4
  end

  add_index "army_list_unit_troops", ["army_list_unit_id"], name: "index_army_list_unit_troops_on_army_list_unit_id", using: :btree
  add_index "army_list_unit_troops", ["troop_id"], name: "index_army_list_unit_troops_on_troop_id", using: :btree

  create_table "army_list_units", force: :cascade do |t|
    t.integer  "army_list_id",     limit: 4
    t.integer  "unit_id",          limit: 4
    t.integer  "unit_category_id", limit: 4
    t.string   "name",             limit: 255
    t.decimal  "value_points",                   precision: 8, scale: 2
    t.integer  "size",             limit: 4
    t.integer  "position",         limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notes",            limit: 65535
    t.string   "magic",            limit: 255
  end

  add_index "army_list_units", ["army_list_id"], name: "index_army_list_units_on_army_list_id", using: :btree
  add_index "army_list_units", ["unit_category_id"], name: "index_army_list_units_on_unit_category_id", using: :btree
  add_index "army_list_units", ["unit_id"], name: "index_army_list_units_on_unit_id", using: :btree

  create_table "army_list_units_extra_items", force: :cascade do |t|
    t.integer "army_list_unit_id", limit: 4, null: false
    t.integer "extra_item_id",     limit: 4, null: false
  end

  add_index "army_list_units_extra_items", ["army_list_unit_id"], name: "index_army_list_units_extra_items_on_army_list_unit_id", using: :btree
  add_index "army_list_units_extra_items", ["extra_item_id"], name: "index_army_list_units_extra_items_on_extra_item_id", using: :btree

  create_table "army_list_units_magic_items", force: :cascade do |t|
    t.integer "army_list_unit_id", limit: 4,             null: false
    t.integer "magic_item_id",     limit: 4,             null: false
    t.integer "quantity",          limit: 4, default: 1, null: false
  end

  add_index "army_list_units_magic_items", ["army_list_unit_id"], name: "index_army_list_units_magic_items_on_army_list_unit_id", using: :btree
  add_index "army_list_units_magic_items", ["magic_item_id"], name: "index_army_list_units_magic_items_on_magic_item_id", using: :btree

  create_table "army_list_units_magic_standards", force: :cascade do |t|
    t.integer "army_list_unit_id", limit: 4, null: false
    t.integer "magic_standard_id", limit: 4, null: false
  end

  add_index "army_list_units_magic_standards", ["army_list_unit_id"], name: "index_army_list_units_magic_standards_on_army_list_unit_id", using: :btree
  add_index "army_list_units_magic_standards", ["magic_standard_id"], name: "index_army_list_units_magic_standards_on_magic_standard_id", using: :btree

  create_table "army_list_units_unit_options", force: :cascade do |t|
    t.integer "army_list_unit_id", limit: 4,             null: false
    t.integer "unit_option_id",    limit: 4,             null: false
    t.integer "quantity",          limit: 4, default: 1, null: false
  end

  add_index "army_list_units_unit_options", ["army_list_unit_id"], name: "index_army_list_units_unit_options_on_army_list_unit_id", using: :btree
  add_index "army_list_units_unit_options", ["unit_option_id"], name: "index_army_list_units_unit_options_on_unit_option_id", using: :btree

  create_table "army_lists", force: :cascade do |t|
    t.integer  "army_id",      limit: 4,                             null: false
    t.integer  "user_id",      limit: 4,                             null: false
    t.string   "name",         limit: 255,                           null: false
    t.decimal  "value_points",               precision: 8, scale: 2, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notes",        limit: 65535
    t.string   "uuid",         limit: 36,                            null: false
  end

  add_index "army_lists", ["army_id"], name: "index_army_lists_on_army_id", using: :btree
  add_index "army_lists", ["user_id"], name: "index_army_lists_on_user_id", using: :btree

  create_table "equipments", force: :cascade do |t|
    t.integer "unit_id",  limit: 4,   null: false
    t.string  "name",     limit: 255, null: false
    t.integer "position", limit: 4,   null: false
    t.integer "troop_id", limit: 4
  end

  add_index "equipments", ["troop_id"], name: "index_equipments_on_troop_id", using: :btree
  add_index "equipments", ["unit_id"], name: "index_equipments_on_unit_id", using: :btree

  create_table "extra_item_categories", force: :cascade do |t|
    t.integer "army_id", limit: 4,   null: false
    t.string  "name",    limit: 255, null: false
  end

  add_index "extra_item_categories", ["army_id"], name: "index_extra_item_categories_on_army_id", using: :btree

  create_table "extra_items", force: :cascade do |t|
    t.integer "extra_item_category_id", limit: 4,                           null: false
    t.string  "name",                   limit: 255,                         null: false
    t.decimal "value_points",                       precision: 8, scale: 2, null: false
  end

  add_index "extra_items", ["extra_item_category_id"], name: "index_extra_items_on_extra_item_category_id", using: :btree

  create_table "magic_item_categories", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  create_table "magic_items", force: :cascade do |t|
    t.integer "magic_item_category_id", limit: 4,                                           null: false
    t.integer "army_id",                limit: 4
    t.string  "name",                   limit: 255,                                         null: false
    t.decimal "value_points",                       precision: 8, scale: 2,                 null: false
    t.integer "override_id",            limit: 4
    t.boolean "is_multiple",                                                default: false, null: false
  end

  add_index "magic_items", ["army_id"], name: "index_magic_items_on_army_id", using: :btree
  add_index "magic_items", ["magic_item_category_id"], name: "index_magic_items_on_magic_item_category_id", using: :btree
  add_index "magic_items", ["override_id"], name: "index_magic_items_on_override_id", using: :btree

  create_table "magic_standards", force: :cascade do |t|
    t.integer "army_id",      limit: 4
    t.string  "name",         limit: 255, null: false
    t.integer "value_points", limit: 4,   null: false
    t.integer "override_id",  limit: 4
  end

  add_index "magic_standards", ["army_id"], name: "index_magic_standards_on_army_id", using: :btree
  add_index "magic_standards", ["override_id"], name: "index_magic_standards_on_override_id", using: :btree

  create_table "special_rules", force: :cascade do |t|
    t.integer "unit_id",  limit: 4,   null: false
    t.string  "name",     limit: 255, null: false
    t.integer "position", limit: 4,   null: false
    t.integer "troop_id", limit: 4
  end

  add_index "special_rules", ["troop_id"], name: "index_special_rules_on_troop_id", using: :btree
  add_index "special_rules", ["unit_id"], name: "index_special_rules_on_unit_id", using: :btree

  create_table "troop_types", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  create_table "troops", force: :cascade do |t|
    t.integer "unit_id",        limit: 4,                           null: false
    t.integer "troop_type_id",  limit: 4
    t.string  "name",           limit: 255,                         null: false
    t.decimal "value_points",               precision: 8, scale: 2
    t.integer "position",       limit: 4,                           null: false
    t.string  "M",              limit: 5
    t.string  "WS",             limit: 5
    t.string  "BS",             limit: 5
    t.string  "S",              limit: 5
    t.string  "T",              limit: 5
    t.string  "W",              limit: 5
    t.string  "I",              limit: 5
    t.string  "A",              limit: 5
    t.string  "LD",             limit: 5
    t.integer "min_size",       limit: 4
    t.integer "unit_option_id", limit: 4
  end

  add_index "troops", ["troop_type_id"], name: "index_troops_on_troop_type_id", using: :btree
  add_index "troops", ["unit_id"], name: "index_troops_on_unit_id", using: :btree
  add_index "troops", ["unit_option_id"], name: "index_troops_on_unit_option_id", using: :btree

  create_table "unit_categories", force: :cascade do |t|
    t.string  "name",      limit: 255, null: false
    t.integer "min_quota", limit: 4
    t.integer "max_quota", limit: 4
  end

  create_table "unit_options", force: :cascade do |t|
    t.integer "unit_id",            limit: 4,                                           null: false
    t.integer "parent_id",          limit: 4
    t.string  "name",               limit: 255,                                         null: false
    t.decimal "value_points",                   precision: 8, scale: 2
    t.integer "position",           limit: 4,                                           null: false
    t.boolean "is_per_model",                                                           null: false
    t.boolean "is_magic_items",                                                         null: false
    t.boolean "is_magic_standards",                                                     null: false
    t.boolean "is_unique_choice",                                                       null: false
    t.boolean "is_extra_items",                                                         null: false
    t.integer "mount_id",           limit: 4
    t.boolean "is_multiple",                                            default: false, null: false
  end

  add_index "unit_options", ["mount_id"], name: "index_unit_options_on_mount_id", using: :btree
  add_index "unit_options", ["parent_id"], name: "index_unit_options_on_parent_id", using: :btree
  add_index "unit_options", ["unit_id"], name: "index_unit_options_on_unit_id", using: :btree

  create_table "units", force: :cascade do |t|
    t.integer "army_id",          limit: 4,                                             null: false
    t.integer "unit_category_id", limit: 4,                                             null: false
    t.string  "name",             limit: 255,                                           null: false
    t.integer "min_size",         limit: 4,                             default: 1,     null: false
    t.integer "max_size",         limit: 4
    t.decimal "value_points",                   precision: 8, scale: 2
    t.string  "magic",            limit: 255
    t.text    "notes",            limit: 65535
    t.boolean "is_unique",                                              default: false, null: false
  end

  add_index "units", ["army_id"], name: "index_units_on_army_id", using: :btree
  add_index "units", ["unit_category_id"], name: "index_units_on_unit_category_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 128, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   limit: 255
    t.integer  "favorite_army_id",       limit: 4
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["favorite_army_id"], name: "index_users_on_favorite_army_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "army_list_units", "army_lists"
  add_foreign_key "army_list_units", "units"
  add_foreign_key "army_list_units_extra_items", "army_list_units", on_delete: :cascade
  add_foreign_key "army_list_units_extra_items", "extra_items", on_delete: :cascade
  add_foreign_key "army_list_units_magic_items", "army_list_units", on_delete: :cascade
  add_foreign_key "army_list_units_magic_items", "magic_items", on_delete: :cascade
  add_foreign_key "army_list_units_magic_standards", "army_list_units", on_delete: :cascade
  add_foreign_key "army_list_units_magic_standards", "magic_standards", on_delete: :cascade
  add_foreign_key "army_list_units_unit_options", "army_list_units", on_delete: :cascade
  add_foreign_key "army_list_units_unit_options", "unit_options", on_delete: :cascade
  add_foreign_key "army_lists", "armies"
  add_foreign_key "army_lists", "users"
  add_foreign_key "equipments", "troops", on_delete: :nullify
  add_foreign_key "equipments", "units"
  add_foreign_key "extra_item_categories", "armies"
  add_foreign_key "extra_items", "extra_item_categories"
  add_foreign_key "magic_items", "armies"
  add_foreign_key "magic_items", "magic_item_categories"
  add_foreign_key "magic_items", "magic_items", column: "override_id"
  add_foreign_key "magic_standards", "armies"
  add_foreign_key "magic_standards", "magic_standards", column: "override_id"
  add_foreign_key "special_rules", "troops", on_delete: :nullify
  add_foreign_key "special_rules", "units"
  add_foreign_key "troops", "troop_types"
  add_foreign_key "troops", "unit_options", on_delete: :nullify
  add_foreign_key "troops", "units"
  add_foreign_key "unit_options", "unit_options", column: "parent_id"
  add_foreign_key "unit_options", "units"
  add_foreign_key "unit_options", "units", column: "mount_id", on_delete: :nullify
  add_foreign_key "units", "armies"
  add_foreign_key "units", "unit_categories"
  add_foreign_key "users", "armies", column: "favorite_army_id", on_delete: :nullify
end
