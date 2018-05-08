class RentalsController < ApplicationController
  def checkout
    rental = Rental.create_from_request(params)
    if rental.save
      render json: { id: rental.id }, status: :created
    else
      render json: {
        errors: rental.errors.messages
        }, status: :bad_request
    end
  end

  def checkin

  end
end
