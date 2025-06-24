class AddRepeatsToCalendarTasks < ActiveRecord::Migration[8.0]
  def change
    add_column :calendar_tasks, :repeats, :string, null: false, default: "none"
  end
end
