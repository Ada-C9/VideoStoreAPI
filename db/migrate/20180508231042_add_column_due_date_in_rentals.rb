class AddColumnDueDateInRentals < ActiveRecord::Migration[5.1]
  def change
    add_column :rentals, :due_date, :date
  end
end
