class CreateRecords < ActiveRecord::Migration[8.0]
  def change
    create_table :records do |t|
      t.string :title
      t.integer :discogs_id
      t.integer :running_time
      t.references :artist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
