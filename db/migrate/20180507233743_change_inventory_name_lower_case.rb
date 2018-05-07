class ChangeInventoryNameLowerCase < ActiveRecord::Migration[5.1]
  def change
    rename_column :movies, :Inventory, :inventory
  end
end
