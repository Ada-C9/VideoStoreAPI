class Movie < ApplicationRecord

  validates :title, :inventory, presence: true

  validates :inventory, numericality: true

  has_many :rentals

  def self.decrement(movie)

    if movie && movie.available_inventory > 0
      movie.available_inventory -= 1
    else
      # figure out how we will process invalid requests
    end
  end

end
