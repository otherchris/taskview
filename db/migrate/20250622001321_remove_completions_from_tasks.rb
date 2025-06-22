class RemoveCompletionsFromTasks < ActiveRecord::Migration[8.0]
  def change
    remove_column :tasks, :completions, :json
  end
end
