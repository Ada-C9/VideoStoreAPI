class ChangeDataTypeReleaseDate < ActiveRecord::Migration[5.1]
  def change
    change_column :movies, :release_date, :string
  end
end
