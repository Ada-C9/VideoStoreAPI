require 'pry'
class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  validate :available?

  # custom validation method
  # if no copies of a movie are available, this will
  # throw an error when you attempt to save the Rental
  def available?
    if self.movie.available_inventory <= 0
      errors.add(:movie_id, "This movie is not in stock.")
    end
  end
end
