class AddDueDateToRental < ActiveRecord::Migration[5.1]
  def change
    add_column :rentals, :due_date, :datetime
  end
end
