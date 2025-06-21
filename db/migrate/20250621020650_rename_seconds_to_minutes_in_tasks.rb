class RenameSecondsToMinutesInTasks < ActiveRecord::Migration[8.0]
  def change
    rename_column :tasks, :seconds, :minutes
  end
end
