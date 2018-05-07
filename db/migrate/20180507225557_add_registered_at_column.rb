class AddRegisteredAtColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :registered_at, :datetime
  end
end
