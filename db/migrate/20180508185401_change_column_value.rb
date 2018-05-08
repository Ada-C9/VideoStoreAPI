class ChangeColumnValue < ActiveRecord::Migration[5.1]
  def change
    change_column :customers, :movies_checked_out_count, :integer
    change_column :movies, :available_inventory, :integer
  end
end
