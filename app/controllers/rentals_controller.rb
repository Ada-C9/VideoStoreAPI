class RentalsController < ApplicationController

  def checkout
    # checkout_date = DateTime.now
    rental = Rental.new(rental_params)
    # customer_id = Customer.find_by(id: rental_params[:customer_id])
    # movie_id = Movie.find_by(id: rental_params[:movie_id])

    # rental.due_date = (checkout_date + 7)
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
    params.permit(:due_date, :customer_id, :movie_id)
  end
end
