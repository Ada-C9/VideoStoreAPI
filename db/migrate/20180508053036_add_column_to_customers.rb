class AddColumnToCustomers < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :movies_checked_out, :integer
  end
end
