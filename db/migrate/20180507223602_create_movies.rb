class CreateMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :overview
      t.date :date
      t.integer :inventory

      t.timestamps
    end
  end
end
