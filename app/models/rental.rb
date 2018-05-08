class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  # validates :checkout_date, presence: true
  validates :movie_id, presence: true
  validates :customer_id, presence: true

  # after_save :set_return_to_false
  # after_save :reduce_inventory


  # private
  #
  # def set_return_to_false
  #   rental.update(returned?: false)
  # end

end
