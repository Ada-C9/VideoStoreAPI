class Rental < ApplicationRecord
  validates :checkout, presence: true
  validates :due_date, presence: true
  validates :customer_id, presence: true
  validates :movie_id, presence: true
end
