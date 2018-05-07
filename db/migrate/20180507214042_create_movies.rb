class CreateMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :overview
      t.date :release_date
      t.integer :Inventory

      t.timestamps
    end
  end
end
