class AddDefaultValueToAvailableInventoryForRealsies < ActiveRecord::Migration[5.1]
  def change
    change_column :movies, :available_inventory, :integer

    reversible do |dir|
      dir.up { Movie.update_all('available_inventory = inventory') }
    end
  end
end
