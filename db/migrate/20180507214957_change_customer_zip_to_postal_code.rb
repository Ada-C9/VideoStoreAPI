class ChangeCustomerZipToPostalCode < ActiveRecord::Migration[5.1]
  def change
    rename_column :customers, :zip, :postal_code
  end
end
