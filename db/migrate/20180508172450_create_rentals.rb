class CreateRentals < ActiveRecord::Migration[5.1]
  def change
    create_table :rentals do |t|
      t.string :checkout_date
      t.string :due_date
      t.references :customer, foreign_key: true
      t.references :movie, foreign_key: true

      t.timestamps
    end
  end
end
