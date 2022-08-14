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

ActiveRecord::Schema.define(version: 2022_08_07_135137) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "name"
    t.integer "category"
    t.string "duration"
    t.string "video"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_activities", force: :cascade do |t|
    t.bigint "activity_id"
    t.bigint "game_id"
    t.boolean "completed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_game_activities_on_activity_id"
    t.index ["game_id"], name: "index_game_activities_on_game_id"
  end

  create_table "games", force: :cascade do |t|
    t.boolean "win", default: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "level"
    t.index ["user_id"], name: "index_games_on_user_id"
  end

  create_table "streaks", force: :cascade do |t|
    t.bigint "user_id"
    t.boolean "active", default: true
    t.integer "days_in_a_row", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_streaks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "game_activities", "activities"
  add_foreign_key "game_activities", "games"
  add_foreign_key "games", "users"
  add_foreign_key "streaks", "users"
end
