class AddRentalsJoin < ActiveRecord::Migration[5.1]
  def change
    create_table :customers_rentals do |t|
      t.belongs_to :customer, index: true
      t.belongs_to :movie, index: true

      t.timestamps
    end
  end
end
