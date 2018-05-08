class ChangeCheckouttoDatetime < ActiveRecord::Migration[5.1]
  def change
    change_column :rentals, :check_out, :datetime
  end
end
