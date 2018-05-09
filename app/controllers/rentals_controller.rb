class RentalsController < ApplicationController

  def create
    rental = Rental.new(rental_params)

    movie = find_rental_movie(rental_params)
    if movie.nil?
      render json: {errors: "Movie with id #{rental_params[:movie_id]} doesn't exist"}, status: :bad_request
      return
    end

    if movie.available_inventory == 0
      render json: { errors: "No available inventory for #{movie.title}" }, status: :bad_request
      return
    end

    if rental.save
      movie.decrement_available_inventory
      render json: { id: rental.id, due_date: rental.due_date }, status: :ok
    else
      render json: { errors: rental.errors.messages }, status: :bad_request
    end

  end

  # def update
  #
  # end

  private
  def rental_params
    return params.require(:rental).permit(:movie_id, :customer_id)
  end

  def find_rental_movie(rental_params)
    return Movie.find_by(id: rental_params[:movie_id])
  end

end
