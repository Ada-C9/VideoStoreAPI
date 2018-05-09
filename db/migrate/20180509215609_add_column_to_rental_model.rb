class AddColumnToRentalModel < ActiveRecord::Migration[5.1]
  def change
    add_column :rentals, :checked_out, :boolean
  end
end
