class RentalsController < ApplicationController

  def checkout
    checkout_date = DateTime.now
    movie = Movie.find_by(id: params[:movie_id])
    customer = Customer.find_by(id: params[:customer_id])
    due_date = (checkout_date + 7)

    rental = Rental.new(movie, customer, due_date)

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
