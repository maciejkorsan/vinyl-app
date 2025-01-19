class CreateLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :logs do |t|
      t.references :record, null: false, foreign_key: true
      t.date :date

      t.timestamps
    end
  end
end
