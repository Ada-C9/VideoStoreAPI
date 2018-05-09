class RentalsController < ApplicationController

  def check_out

    rental = Rental.new(rental_params)

    if rental.movie.available_to_rent?
      if rental.save
        rental.movie.reduce_available_inventory
        render json: { id: rental.id, customer_id: rental.customer_id, movie_id: rental.movie_id }, status: :created
      else
        render json: { errors: rental.errors.messages }, status: :bad_request
      end
    else
      render json: { errors: rental.errors.messages }, status: :bad_request
    end
  end

  private
  def rental_params
    params.require(:rental).permit(:movie_id, :customer_id)
  end
end
