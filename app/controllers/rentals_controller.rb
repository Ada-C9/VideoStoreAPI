class RentalsController < ApplicationController

  def checkout

    rental = Rental.new(rental_params)
    rental.checkout_date = DateTime.now
    rental.due_date = (checkout_date + 7)

    if rental.save
      #success
      render json: rental_params, status: :ok
    else
      #failure
      render json: {errors: rental.errors.messages }, status: :bad_request
    end

  end

  def checkin


  end

  private
  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end
