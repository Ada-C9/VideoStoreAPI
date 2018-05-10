class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  validate :available?

  # custom validation method, errors hash TBD!
  def available?
    return true if self.movie.available_inventory > 0
    return false
  end

end
