class FixReferenceTypoInRentals < ActiveRecord::Migration[5.1]
  def change
    remove_column :rentals, :customers_id

    add_reference :rentals, :customer, foreign_key: true
  end
end
