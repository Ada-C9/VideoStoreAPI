class Rental < ApplicationRecord

  belongs_to :customer
  belongs_to :movie

  validates :customer_id, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :movie_id, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
