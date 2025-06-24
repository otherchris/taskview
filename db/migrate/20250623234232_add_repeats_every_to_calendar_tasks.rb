class AddRepeatsEveryToCalendarTasks < ActiveRecord::Migration[8.0]
  def change
    add_column :calendar_tasks, :repeats_every, :integer, null: false, default: 1
  end
end
