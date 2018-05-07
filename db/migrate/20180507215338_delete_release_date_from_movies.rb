class DeleteReleaseDateFromMovies < ActiveRecord::Migration[5.1]
  def change
    remove_column :movies, :release_date
  end
end
