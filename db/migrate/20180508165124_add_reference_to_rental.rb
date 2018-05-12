class AddReferenceToRental < ActiveRecord::Migration[5.1]
  def change
    remove_reference :rentals, :movie
    remove_reference :rentals, :customer

    add_reference :rentals, :movie, foreign_key: true
    add_reference :rentals, :customer, foreign_key: true
  end
end
