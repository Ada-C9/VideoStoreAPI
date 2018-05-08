class DropTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :customers_rentals
  end
end
