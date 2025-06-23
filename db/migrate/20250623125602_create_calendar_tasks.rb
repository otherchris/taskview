class CreateCalendarTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :calendar_tasks do |t|
      t.string :title
      t.text :description
      t.date :due_date

      t.timestamps
    end
  end
end
