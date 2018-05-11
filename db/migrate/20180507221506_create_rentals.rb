class CreateRentals < ActiveRecord::Migration[5.1]
  def change
    create_table :rentals do |t|
      add_reference :rentals, :movies, foreign_key: true
      add_reference :rentals, :customers, foreign_key: true
      t.timestamps
    end
  end
end
