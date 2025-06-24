class AddAssignedDateToCompletions < ActiveRecord::Migration[8.0]
  def change
    add_column :completions, :assigned_date, :date
  end
end
