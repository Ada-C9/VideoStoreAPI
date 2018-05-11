class CreateRentals < ActiveRecord::Migration[5.1]
  def change
    create_table :rentals do |t|
      t.integer :movie_id
      t.integer :customer_id
      t.date :checkout_date
      t.date :due_date

      t.timestamps
    end
  end
end
