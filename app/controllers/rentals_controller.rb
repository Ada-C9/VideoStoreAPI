class RentalsController < ApplicationController
  def checkin

  end

  def checkout
    customer = Customer.find(params[:customer_id])
    movie = Movie.find(params[:movie_id])

    Rental.new(customer_id: customer, movie_id: movie)
  end

  private
  def checkout_params
    params.permit(:customer_id, :movie_id)
  end

end
