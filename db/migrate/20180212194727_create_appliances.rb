class CreateAppliances < ActiveRecord::Migration[5.0]
  def change
    create_table :appliances do |t|
      t.string :name, limit: 256
      t.string :manufacturer
      t.string :model
      t.string :serial
      t.string :ip_addr
      t.string :user_name
      t.string :password
      t.string :url
      t.references :system, foreign_key: true

      t.timestamps
    end
    add_index :appliances, :name, unique: true
  end
end
