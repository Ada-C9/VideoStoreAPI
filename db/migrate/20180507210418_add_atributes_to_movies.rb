class AddAtributesToMovies < ActiveRecord::Migration[5.1]
  def change
    add_column :movies, :title, :string
    add_column :movies, :overview, :string
    add_column :movies, :release_date, :date
    add_column :movies, :inventory, :integer

    add_column :customers, :name, :string
    add_column :customers, :registered_at, :datetime
    add_column :customers, :address, :string
    add_column :customers, :city, :string
    add_column :customers, :state, :string
    add_column :customers, :postal_code, :string
    add_column :customers, :phone, :string

    add_column :rentals, :end_date, :date
    add_column :rentals, :start_date, :date
  end
end
