class RemoveAvailableInventoryColumnFromMovies < ActiveRecord::Migration[5.1]
  def change
    remove_column :movies, :available_inventory
  end
end
