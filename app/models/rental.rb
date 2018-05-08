class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer

  def self.create_from_request(params_hash)
    rental_data = {
      checkout_date: DateTime.now,
      due_date: DateTime.now + 7,
      customer_id: params_hash[:customer_id],
      movie_id: params_hash[:movie_id]
    }

    rental = self.new(rental_data)

    # TODO: liked the way this worked with just return rental.save for boolean, figure it out if time?
    return rental

  end
end
