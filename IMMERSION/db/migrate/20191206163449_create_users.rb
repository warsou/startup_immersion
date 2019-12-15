class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :first_name
      t.string :last_name
      t.belongs_to :situation, index: true
      t.text :formation
      t.belongs_to :activity, index: true
      t.text :description
      t.string :linked_in_url
      t.belongs_to :newsletter, index: true

      t.timestamps
    end
  end
end
