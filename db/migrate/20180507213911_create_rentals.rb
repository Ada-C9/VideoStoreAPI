class CreateRentals < ActiveRecord::Migration[5.1]
  def change
    create_table :rentals do |t|
      t.date :checkout_date
      t.date :due_date
      t.boolean :returned?

      t.timestamps
    end
  end
end
