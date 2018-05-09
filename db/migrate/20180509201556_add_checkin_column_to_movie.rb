class AddCheckinColumnToMovie < ActiveRecord::Migration[5.1]
  def change
    add_column :movies, :checkin_date, :date
  end
end
