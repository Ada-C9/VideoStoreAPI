class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer
  validates :checked_out, presence: true
  validates :due_date, presence: true
  validates :check_in_status,  inclusion: { in: [ true, false ] }
  validate :rental_available


  def rental_available
    return unless errors.blank?

    units_checked_out = movie.rentals.select { |rental| rental.check_in_status == false }
    units_available = movie.inventory - units_checked_out.count
    if units_available == 0
      errors.add(:movie, "This movie is not available")
    end
  end

end
