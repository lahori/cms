class CreateDisks < ActiveRecord::Migration[5.0]
  def change
    create_table :disks do |t|
      t.string :device_name
      t.string :model, limit: 128
      t.string :vendor_id, limit: 128
      t.string :product_id, limit: 128
      t.string :serail, limit: 128
      t.string :revision, limit: 64
      t.string :size, limit: 128
      t.string :media_type, limit: 64
      t.string :interface, limit: 64
      t.string :state, limit: 64
      t.string :location, limit: 128
      t.references :appliance, foreign_key: true

      t.timestamps
    end
  end
end
