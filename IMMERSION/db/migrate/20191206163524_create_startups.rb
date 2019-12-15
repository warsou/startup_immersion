class CreateStartups < ActiveRecord::Migration[5.2]
  def change
    create_table :startups do |t|
      t.string :name
      t.text :catch_phrase
      t.string :website_url
      t.text :description

      t.timestamps
    end
  end
end
