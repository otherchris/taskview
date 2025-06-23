# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_06_23_132209) do
  create_table "calendar_tasks", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.date "due_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "completions", force: :cascade do |t|
    t.string "completable_type", null: false
    t.integer "completable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["completable_type", "completable_id"], name: "index_completions_on_completable"
  end

  create_table "daily_tasks", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "times_per_day", default: 1
    t.text "schedule"
  end

  create_table "interval_tasks", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "interval"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
