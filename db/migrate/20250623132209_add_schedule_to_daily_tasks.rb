class AddScheduleToDailyTasks < ActiveRecord::Migration[8.0]
  def change
    add_column :daily_tasks, :schedule, :text
  end
end
