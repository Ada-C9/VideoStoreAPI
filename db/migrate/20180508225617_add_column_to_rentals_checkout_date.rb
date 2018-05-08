class AddColumnToRentalsCheckoutDate < ActiveRecord::Migration[5.1]
  def change
    add_column :rentals, :checkout_date, :date
    remove_column :rentals, :due_date
  end
end
