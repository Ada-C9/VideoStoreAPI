class ChangePhoneStringOnCustomersTable < ActiveRecord::Migration[5.1]
  def change
    rename_column :customers, :phone_string, :phone
  end
end
