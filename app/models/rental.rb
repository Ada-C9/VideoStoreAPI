# class RentalValidator < ActiveModel::Validator
#
#   def validate(rental)
#     duplicate_rental = Rental.find_by(
#       movie_id: rental.movie_id,
#       customer_id: rental.customer_id,
#       check_in: nil
#     )
#
#     unless duplicate_rental.nil?
#       rental.errors[:movie_id] << "Movie has already been checked out by this customer."
#     end
#   end
#
# end


class Rental < ApplicationRecord
  # include ActiveModel::Validations
  # validates_with RentalValidator

  belongs_to :customer
  belongs_to :movie

  validates :movie_id, presence: true
  validates :customer_id, presence: true
  validates :check_out, presence: true
  validates :due_date, presence: true
  validates_datetime :due_date, :after => :check_out
  validates_datetime :check_in, :after => :check_out, allow_nil: true


  def self.find_rental(movie_id, customer_id)
    self.all.where(movie_id: movie_id, customer_id: customer_id, check_in: nil).first
  end

end
