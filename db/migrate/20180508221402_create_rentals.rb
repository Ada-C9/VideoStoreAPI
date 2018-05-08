class CreateRentals < ActiveRecord::Migration[5.1]
  def change
    create_table :rentals do |t|
      t.datetime "due_date"
      t.datetime "checkout_date"
      t.datetime "checkin_date"

      t.timestamps
    end
  end
end
