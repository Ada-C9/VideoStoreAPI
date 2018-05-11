class AddOverviewToMovies < ActiveRecord::Migration[5.1]
  def change
    add_column :movies, :overview, :string
    add_column :movies, :inventory, :integer
  end
end
