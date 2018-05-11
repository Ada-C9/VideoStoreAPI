class AddStatusColumnToRentals < ActiveRecord::Migration[5.1]
  def change
    add_column :rentals, :check_in_status, :boolean
  end
end
