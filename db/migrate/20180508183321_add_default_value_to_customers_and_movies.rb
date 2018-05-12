class AddDefaultValueToCustomersAndMovies < ActiveRecord::Migration[5.1]
  def change
    change_column :customers, :movies_checked_out_count, :integer, :default => 0
    change_column :movies, :available_inventory, :integer, :default => :inventory
  end
end
