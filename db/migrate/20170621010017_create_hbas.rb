class CreateHbas < ActiveRecord::Migration[5.0]
  def change
    create_table :hbas do |t|
      t.string :adapter_id, limit: 128
      t.string :model, limit: 128
      t.string :product_id, limit: 128
      t.string :vendor_id, limit: 128
      t.string :adaptor_description, limit: 256
      t.string :hw_version, limit: 64
      t.string :fw_version, limit: 64
      t.string :driver_name, limit: 128
      t.string :driver_version, limit: 128
      t.integer :lu_count
      t.integer :port_count
      t.integer :peer_count
      t.references :appliance, foreign_key: true

      t.timestamps
    end
  end
end
