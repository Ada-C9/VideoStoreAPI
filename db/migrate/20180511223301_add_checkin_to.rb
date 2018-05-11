class AddCheckinTo < ActiveRecord::Migration[5.1]
  def change
    add_column :rentals, :checked_in, :boolean, default: false
  end
end
