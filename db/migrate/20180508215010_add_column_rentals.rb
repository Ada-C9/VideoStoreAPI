class AddColumnRentals < ActiveRecord::Migration[5.1]
  def change
    add_column :rentals, :movie_id, :integer

    add_column :rentals, :customer_id, :integer
  end
end
