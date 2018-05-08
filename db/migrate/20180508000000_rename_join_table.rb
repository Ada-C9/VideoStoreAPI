class RenameJoinTable < ActiveRecord::Migration[5.1]
  def change
    rename_table :customers_movies_joins, :customers_movies
  end
end
