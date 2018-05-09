class RentalsController < ApplicationController
  def checkin

  end

  def checkout
    customer = Customer.find(check_params[:customer_id])
    movie = Movie.find(check_params[:movie_id])

    Rental.new(customer_id: customer, movie_id: movie)
  end

  def checkin

    rental = Rental.find(check_params[:rental_id])
    rental.update_attributes checkin_date: Date.now

    if rental.save
      Customer.find(rental.customer_id).update_attributes movies_checked_out_count:  movies_checked_out_count-1

      Movie.find(rental.movie_id).update_attributes available_inventory: available_inventory+1

      @movie = rental.movie_id
      @movie.increase_inventory

      render json: { id: rental.id }, status: :ok
    else
      render json: { errors: rental.errors.messages }, status: :bad_request

    end

    private
    def check_params
      params.permit(:customer_id, :movie_id)
    end
  end
end
