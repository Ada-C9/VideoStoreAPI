class AddAvailableInventoryWithDefaultValue < ActiveRecord::Migration[5.1]
  def change
    add_column :movies, :available_inventory, :integer, default: 0
  end
end
