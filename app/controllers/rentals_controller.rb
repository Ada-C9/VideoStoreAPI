class RentalsController < ApplicationController
  def checkin

  end

  def checkout
    customer = Customer.find(check_params[:customer_id])
    movie = Movie.find(check_params[:movie_id])

    Rental.new(customer_id: customer, movie_id: movie)
  end

  private
  def check_params
    params.permit(:customer_id, :movie_id)
  end

end
