class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie
  validates :customer_id, presence :true
  validates :movie_id, presence :true
  validates :check_in, presence :true
  validates :check_out, presence :true
end
