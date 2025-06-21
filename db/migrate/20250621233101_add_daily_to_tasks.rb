class AddDailyToTasks < ActiveRecord::Migration[8.0]
  def change
    add_column :tasks, :daily, :boolean
  end
end
