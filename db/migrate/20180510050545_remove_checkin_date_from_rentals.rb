class RemoveCheckinDateFromRentals < ActiveRecord::Migration[5.1]
  def change
    remove_column :rentals, :checkin_date, :date
  end
end
