class CreateSystems < ActiveRecord::Migration[5.0]
  def change
    create_table :systems do |t|
      t.string :name
      t.string :system_type, limit: 24
      t.string :purpose
      t.string :status

      t.timestamps
    end
    add_index :systems, :name, unique: true
  end
end
