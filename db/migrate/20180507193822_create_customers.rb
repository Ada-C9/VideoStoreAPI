class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :registered_at
      t.string :postal_code
      t.string :phone_number
      t.integer :checked_out_count
      t.timestamps
    end
  end
end
