class AddColumnsAgain < ActiveRecord::Migration[5.1]
  def change
    add_column :rentals, :check_out_date, :date

    add_column :rentals, :due_date, :date
  end
end
