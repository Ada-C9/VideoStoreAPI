class AddNewDefaultInventory < ActiveRecord::Migration[5.1]
  def change
    add_column :movies, :inventory, :integer, default: 10
  end
end
