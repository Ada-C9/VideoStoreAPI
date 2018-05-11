class MoveCheckInColumn < ActiveRecord::Migration[5.1]
  def change
    remove_column :movies, :checkin_date, :date 
    add_column :rentals, :checkin_date, :date
  end

end
