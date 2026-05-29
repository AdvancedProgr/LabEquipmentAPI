class AddDefaultToEquipmentStatus < ActiveRecord::Migration[8.1]
  def change
    change_column_default :equipment, :status, "available"
  end
end
