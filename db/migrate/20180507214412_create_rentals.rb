class CreateRentals < ActiveRecord::Migration[5.1]
  def change
    create_table :rentals do |t|
      t.integer :customer_id
      t.integer :movie_id
      t.date :check_in
      t.date :check_out

      t.timestamps
    end
  end
end
