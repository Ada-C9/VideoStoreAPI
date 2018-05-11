class AddCheckedOutStatusToRentals < ActiveRecord::Migration[5.1]
  def change
    add_column :rentals, :checked_out_status, :boolean
  end
end
