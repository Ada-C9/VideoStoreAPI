class Rentals < ActiveRecord::Migration[5.1]
  def change
    create_table :rentals do |t|
     t.belongs_to :movie, index: true
     t.belongs_to :customer, index: true
     t.timestamps
   end
  end
end
