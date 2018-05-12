class AddColumnsToRentalModel < ActiveRecord::Migration[5.1]
  def change
    add_column(:rentals, :checkout_date, :date)
    add_column(:rentals, :due_date, :date)
  end
end
