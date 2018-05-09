class AddReturnDateColumnToRentals < ActiveRecord::Migration[5.1]
  def change
    add_column :rentals, :return_date, :date
  end
end
