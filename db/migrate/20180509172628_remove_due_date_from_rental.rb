class RemoveDueDateFromRental < ActiveRecord::Migration[5.1]
  def change
    remove_column :rentals, :due_date
  end
end
