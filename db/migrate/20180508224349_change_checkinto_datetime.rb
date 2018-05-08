class ChangeCheckintoDatetime < ActiveRecord::Migration[5.1]
  def change
    change_column :rentals, :check_in, :datetime
  end
end
