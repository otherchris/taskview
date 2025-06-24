class AddInitialDateToCalendarTasks < ActiveRecord::Migration[8.0]
  def up
    add_column :calendar_tasks, :initial_date, :datetime

    execute("UPDATE calendar_tasks SET initial_date = created_at")

    change_column_null :calendar_tasks, :initial_date, false
  end

  def down
    remove_column :calendar_tasks, :initial_date
  end
end
