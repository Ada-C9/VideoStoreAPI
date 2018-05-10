class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  validate :available?

  # custom validation method, errors hash TBD!
  def available?
    if self.movie.available_inventory > 0
      errors.add(:movie_id, "This movie is not in stock.")
    end
  end

end
