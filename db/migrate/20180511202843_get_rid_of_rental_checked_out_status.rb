class GetRidOfRentalCheckedOutStatus < ActiveRecord::Migration[5.1]
  def change
    remove_column :rentals, :checked_out_status
  end
end
