class CreateRentals < ActiveRecord::Migration[5.1]
  def change
    create_table :rentals do |t|
      t.datetime :check_out
      t.datetime :due_date
      t.datetime :check_in

      t.timestamps
    end
  end
end
