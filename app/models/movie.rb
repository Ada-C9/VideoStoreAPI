class Movie < ApplicationRecord
  has_many :rentals

  validates :title, presence: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def available_inventory
    checked_out_count = Rental.where(movie_id: self.id, check_in: nil).count
    available_inventory = self.inventory - checked_out_count

    return available_inventory
  end

end
