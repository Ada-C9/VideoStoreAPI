class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  validate :available?

  def available?
    return true if self.movie.available_inventory > 0
    return false 
  end

end
