class CreateNics < ActiveRecord::Migration[5.0]
  def change
    create_table :nics do |t|
      t.string :mac, limit: 128
      t.string :media_type, limit: 128
      t.string :name, limit: 128
      t.integer :speed
      t.string :duplex, limit: 64
      t.string :state, limit: 64
      t.references :appliance, foreign_key: true

      t.timestamps
    end
  end
end
