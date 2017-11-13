class CreateEnclosures < ActiveRecord::Migration[5.0]
  def change
    create_table :enclosures do |t|
      t.string :chasis_id, limit: 128
      t.string :model, limit: 128
      t.string :vendor_id, limit: 128
      t.string :product_id, limit: 128
      t.string :revision, limit: 128
      t.integer :total_bay_count
      t.integer :used_bay_count
      t.string :serial_num, limit: 128
      t.references :appliance, foreign_key: true

      t.timestamps
    end
  end
end
