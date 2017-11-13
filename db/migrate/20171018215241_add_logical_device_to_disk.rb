class AddLogicalDeviceToDisk < ActiveRecord::Migration[5.0]
  def change
    add_column :disks, :logical_device, :string, limit: 128
  end
end
