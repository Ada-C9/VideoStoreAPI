class RemoveDateFieldInMoviesTable < ActiveRecord::Migration[5.1]
  def change
    remove_column :movies, :date
  end
end
