class AddReleaseDateColumnToMoviesTable < ActiveRecord::Migration[5.1]
  def change
    add_column :movies, :release_date, :date
  end
end
