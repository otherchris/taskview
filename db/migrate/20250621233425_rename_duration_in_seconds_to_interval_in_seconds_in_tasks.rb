class RenameDurationInSecondsToIntervalInSecondsInTasks < ActiveRecord::Migration[7.1]
  def change
    rename_column :tasks, :duration_in_seconds, :interval_in_seconds
  end
end
