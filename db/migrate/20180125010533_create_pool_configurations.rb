class CreatePoolConfigurations < ActiveRecord::Migration[5.0]
  def change
    create_table :pool_configurations do |t|
      t.string :name
      t.string :redundancy
      t.integer :max_devices
      t.integer :vdev_size
      t.string :media_type
      t.string :disk_size
      t.string :enclosures
      t.boolean :enclosure_redundancy
      t.boolean :force
      t.references :appliance, foreign_key: true

      t.timestamps
    end
  end
end
