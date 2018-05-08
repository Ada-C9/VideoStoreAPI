class AddInitialValueInCustomersTable < ActiveRecord::Migration[5.1]
  def change
    remove_column :customers, :movies_checked_out_count, :integer
  end
end
