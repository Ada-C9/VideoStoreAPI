class Rental < ApplicationRecord

  validates :customer_id, :movie_id, presence: true

  validates :customer_id, :movie_id, numericality: true

  belongs_to :customer, :movie
end
