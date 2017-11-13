class CreateCpus < ActiveRecord::Migration[5.0]
  def change
    create_table :cpus do |t|
      t.integer :chip_id
      t.string :model, limit: 128
      t.string :vendor_id, limit: 64
      t.integer :cores
      t.integer :frequency
      t.integer :threads
      t.references :appliance, foreign_key: true

      t.timestamps
    end
  end
end
