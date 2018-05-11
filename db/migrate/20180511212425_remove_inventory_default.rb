class RemoveInventoryDefault < ActiveRecord::Migration[5.1]
  def change
    remove_column :movies, :inventory, :integer
  end
end
