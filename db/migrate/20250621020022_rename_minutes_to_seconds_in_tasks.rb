class RenameMinutesToSecondsInTasks < ActiveRecord::Migration[8.0]
  def change
    rename_column :tasks, :minutes, :seconds
  end
end
