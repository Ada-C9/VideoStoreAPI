class AddsStatustoRentals < ActiveRecord::Migration[5.1]
  def change
    add_column :rentals, :status, :string
  end
end
