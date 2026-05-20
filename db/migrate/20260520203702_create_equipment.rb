class CreateEquipment < ActiveRecord::Migration[8.1]
  def change
    create_table :equipment do |t|
      t.string :name
      t.string :serial_number
      t.string :status
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
    add_index :equipment, :serial_number, unique: true
  end
end
