class UpdateCustomerPhonenoToPhone < ActiveRecord::Migration[5.1]
  def change
    rename_column :customers, :phone_number, :phone
  end
end
