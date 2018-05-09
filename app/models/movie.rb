class Movie < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals

  validates :title, presence: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true

  def available_inventory
    unavailable = 0
    self.rentals.each do |rental|
      if rental.checkin_date.nil?
        unavailable += 1
      end
    end
    return available_inventory = self.inventory - unavailable
  end

end
