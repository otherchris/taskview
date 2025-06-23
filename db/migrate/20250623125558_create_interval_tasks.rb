class CreateIntervalTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :interval_tasks do |t|
      t.string :title
      t.text :description
      t.integer :interval

      t.timestamps
    end
  end
end
