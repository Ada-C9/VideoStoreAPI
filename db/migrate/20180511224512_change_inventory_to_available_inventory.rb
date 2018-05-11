class ChangeInventoryToAvailableInventory < ActiveRecord::Migration[5.1]
  def change
    rename_column :movies, :inventory, :available_inventory
    add_column :movies, :inventory, :integer, default: 8
  end
end
