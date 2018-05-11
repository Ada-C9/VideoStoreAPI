class CreateRentals < ActiveRecord::Migration[5.1]
  def change
    create_table :rentals do |t|
      t.date :checked_out
      t.date :due_date
      t.timestamps
    end
  end
end
