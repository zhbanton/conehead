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

ActiveRecord::Schema.define(version: 20140711163620) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ingredients", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "ingredients", ["user_id"], name: "index_ingredients_on_user_id", using: :btree

  create_table "production_schedule_entries", force: true do |t|
    t.decimal  "quantity"
    t.integer  "production_schedule_id"
    t.integer  "recipe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "production_schedule_entries", ["production_schedule_id"], name: "index_production_schedule_entries_on_production_schedule_id", using: :btree
  add_index "production_schedule_entries", ["recipe_id"], name: "index_production_schedule_entries_on_recipe_id", using: :btree

  create_table "production_schedules", force: true do |t|
    t.date     "starting_date"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "ending_date"
  end

  add_index "production_schedules", ["user_id"], name: "index_production_schedules_on_user_id", using: :btree

  create_table "recipe_entries", force: true do |t|
    t.decimal  "quantity"
    t.integer  "recipe_id"
    t.integer  "ingredient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recipe_entries", ["ingredient_id"], name: "index_recipe_entries_on_ingredient_id", using: :btree
  add_index "recipe_entries", ["recipe_id"], name: "index_recipe_entries_on_recipe_id", using: :btree

  create_table "recipes", force: true do |t|
    t.string   "name"
    t.text     "note"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_active",  default: true
  end

  add_index "recipes", ["user_id"], name: "index_recipes_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
