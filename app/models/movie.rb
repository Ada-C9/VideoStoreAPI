class Movie < ApplicationRecord

  validates :title, :release_date, :overview, :inventory, presence: true
  has_many :rentals

  def available_inventory
    if  self.inventory
      available_count = self.inventory - Rental.where(movie_id: self.id, returned: false).count
      return available_count
    else
      return 0
    end
  end

  def available?
    return self.available_inventory > 0
  end

end
