class RentalsController < ApplicationController

  def check_in
    # movie = Movie.find_by(id: rental_params[:movie_id])
    # customer = Customer.find_by(id: rental_params[:customer_id])
    # new_rental_data = {
    #   customer_id: customer.id,
    #   movie_id: movie.id
    # }
    rental = Rental.new(rental_params)

    if rental.save
      render json: { id: rental.id, customer_id: rental.customer_id, movie_id: rental.movie_id }, status: :created
    else
      render json: { errors: rental.errors.messages }, status: :bad_request
    end
  end

  private
  def rental_params
    params.require(:rental).permit(:movie_id, :customer_id)
  end
end
