class RemoveColumnFromCustomers < ActiveRecord::Migration[5.1]
  def change
    remove_column :customers, :movies_checked_out, :integer
  end
end
