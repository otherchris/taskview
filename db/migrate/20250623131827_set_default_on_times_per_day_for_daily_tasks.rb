class SetDefaultOnTimesPerDayForDailyTasks < ActiveRecord::Migration[8.0]
  def change
    change_column_default :daily_tasks, :times_per_day, from: nil, to: 1
  end
end
