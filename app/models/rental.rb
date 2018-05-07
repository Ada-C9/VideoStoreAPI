class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  validates :movie_id, presence: true
  validates :customer_id, presence: true
  validates :check_out, presence: true
  validates :due_date, presence: true
  validates :check_in, numericality: greater_than
end
