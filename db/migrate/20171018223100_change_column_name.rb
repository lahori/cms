class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
  	rename_column :disks, :serail, :serial
  end
end
