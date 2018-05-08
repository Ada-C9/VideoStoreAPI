class CreateRentals < ActiveRecord::Migration[5.1]
  def change
    create_table :rentals do |t|
      t.integer :customer_id
      t.integer :movie_id
      t.string :check_out_date
      t.string :due_date
      t.string :check_in_date

      t.timestamps
    end
  end
end
