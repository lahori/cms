class CreateAppliances < ActiveRecord::Migration[5.0]
  def change
    create_table :appliances do |t|
      t.string :manufacturer, limit: 128
      t.string :model, limit: 128
      t.string :serial, limit: 256
      t.string :guid, limit: 128
      t.string :ip_addr, limit: 128
      t.string :user_name, limit: 128
      t.string :password, limit: 64
      t.string :url, limit: 128
      t.references :system, foreign_key: true

      t.timestamps
    end
  end
end
