class RemoveCheckinDateFromMovies < ActiveRecord::Migration[5.1]
  def change
    remove_column :movies, :checkin_date
  end
end
