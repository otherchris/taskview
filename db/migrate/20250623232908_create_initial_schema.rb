class CreateInitialSchema < ActiveRecord::Migration[8.0]
  def change
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
end
