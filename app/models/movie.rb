class Movie < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals

  validates :title, presence: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true

  # calculates and returns a movie's available inventory
  # if rental is out, then due_date is a Date object
  # if rental is back, due_date is nil
  def available_inventory
    unavailable = 0
    self.rentals.each do |rental|
      if rental.due_date
        unavailable += 1
      end
    end
    return available_inventory = self.inventory - unavailable
  end

end
