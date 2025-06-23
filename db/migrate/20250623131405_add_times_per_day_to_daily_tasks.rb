class AddTimesPerDayToDailyTasks < ActiveRecord::Migration[8.0]
  def change
    add_column :daily_tasks, :times_per_day, :integer
  end
end
