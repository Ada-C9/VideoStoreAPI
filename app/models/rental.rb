class RentalValidator < ActiveModel::Validator

  def validate(record)

    if duplicate_rental(record)
      record.errors.add(:base, "Customer has not returned this movie yet.")
    end

    if no_availability(record)
      record.errors.add(:base, "No copies of this movie are currently available")
    end

  end

  private

  def duplicate_rental(record)
    active_previous_rental = Rental.find_by(customer_id: record.customer_id, movie_id: record.movie_id, checkin_date: nil)
    return active_previous_rental
  end

  def no_availability(record)
    return record.movie.available == 0
  end

end



class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer
  validates_with RentalValidator, on: :create

  def self.create_from_request(params_hash)
    rental_data = {
      checkout_date: DateTime.now,
      due_date: DateTime.now + 7,
      customer_id: params_hash[:customer_id],
      movie_id: params_hash[:movie_id]
    }

    rental = self.new(rental_data)

  end
end
