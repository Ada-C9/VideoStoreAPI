class ChangeTypoInPreviousMigration < ActiveRecord::Migration[5.1]
  def change
    remove_column :rentals, :movies_id
    remove_column :rentals, :customers_id

    add_reference :rentals, :movie, foreign_key: true
    add_reference :rentals, :customers, foreign_key: true
  end
end
