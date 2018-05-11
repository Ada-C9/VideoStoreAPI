class Movie < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals

  validates :title, presence: true
  validates :inventory, :numericality => { :greater_than_or_equal_to => 0}

  def self.create_from_request(hash)
    hash["release_date"] = Date.parse(hash["release_date"])

    self.create!(hash)
  end

  def available
    rentals = Rental.where(movie_id: self.id)
    rented = rentals.select{ |rent| !rent.checkin_date }.count
    avail = (self.inventory - rented)
    return avail
  end

end
