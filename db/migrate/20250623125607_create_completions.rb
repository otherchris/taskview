class CreateCompletions < ActiveRecord::Migration[8.0]
  def change
    create_table :completions do |t|
      t.references :completable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
