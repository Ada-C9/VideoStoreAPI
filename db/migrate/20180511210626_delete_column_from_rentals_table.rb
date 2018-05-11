class DeleteColumnFromRentalsTable < ActiveRecord::Migration[5.1]
  def change
    remove_column :rentals, :checkin_date, :datetime
  end
end
