class AddReferenceToRentals < ActiveRecord::Migration[5.1]

  def change
    add_reference :rentals, :movie, foregin_key: true
    add_reference :rentals, :customer, foregin_key: true
  end
end
