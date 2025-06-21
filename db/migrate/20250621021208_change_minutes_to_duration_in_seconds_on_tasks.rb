class ChangeMinutesToDurationInSecondsOnTasks < ActiveRecord::Migration[8.0]
  def change
    remove_column :tasks, :minutes, :integer
    add_column :tasks, :duration_in_seconds, :integer
  end
end
