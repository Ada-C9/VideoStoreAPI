class ChangeReleasedatetoDateTimeType < ActiveRecord::Migration[5.1]
  def change

    change_column :movies, :release_date, :datetime

  end
end
