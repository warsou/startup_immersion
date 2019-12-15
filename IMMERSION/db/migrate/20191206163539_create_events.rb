class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :start_datetime
      t.integer :duration
      t.text :description
      t.string :short_location
      t.string :adress
      t.string :zip_code
      t.string :city
      t.belongs_to :startup, index: true

      t.timestamps
    end
  end
end
