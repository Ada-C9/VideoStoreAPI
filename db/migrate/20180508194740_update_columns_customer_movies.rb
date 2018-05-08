class UpdateColumnsCustomerMovies < ActiveRecord::Migration[5.1]
  def change
    remove_column :customers, :movies_checked_out_count
    remove_column :movies, :available_inventory

    add_column :customers, :movies_checked_out_count, :integer
    add_column :movies, :available_inventory, :integer
  end
end
