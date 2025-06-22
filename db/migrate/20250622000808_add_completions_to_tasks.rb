class AddCompletionsToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :completions, :json, default: []
  end
end
