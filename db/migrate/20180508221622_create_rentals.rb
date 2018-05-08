class CreateRentals < ActiveRecord::Migration[5.1]
  def change
    create_table :rentals do |t|
      t.belongs_to :customer, index: true
      t.belongs_to :movie, index: true
      t.date :due_date
      t.date :check_in
      t.date :check_out
      t.timestamps
    end
  end
end
