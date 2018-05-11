class AddCheckedInventory < ActiveRecord::Migration[5.1]
  def change
    add_column :movies, :available_inventory, :integer
    add_column :customers, :movies_checked_out_count, :integer
  end
end
