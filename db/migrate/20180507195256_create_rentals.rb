class CreateRentals < ActiveRecord::Migration[5.1]
  def change
    create_table :rentals do |t|
      t.date :due_date
      t.boolean :returned, default: false
      t.timestamps
    end
  end
end
