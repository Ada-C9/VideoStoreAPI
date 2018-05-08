class Rental < ApplicationRecord

  validates :customer_id, :movie_id, :check_out_date, :due_date, presence: true

  validates :customer_id, :movie_id, numericality: true

  belongs_to :customer
  belongs_to :movie

end
