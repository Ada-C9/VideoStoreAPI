class RentalsController < ApplicationController

  def checkout
    checkout_date = DateTime.now

    rental = Rental.new(rental_params)
    customer = Customer.find_by(id: params[:customer_id])
    movie = Movie.find_by(id: params[:movie_id])

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
    params.require(:rental).permit(:due_date, :customer_id, :movie_id)
  end
end
