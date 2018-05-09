class RentalsController < ApplicationController

  def create
    rental = Rental.new(rental_params)

    movie = Movie.find_by(id: rental_params[:movie_id])
    if movie.nil?
      render json: {errors: "Movie with id #{rental_params[:movie_id]} doesn't exist"}, status: :bad_request
    else
      if movie.available_inventory > 0
        if rental.save
          render json: { id: rental.id, due_date: rental.due_date }, status: :ok
        else
          render json: { errors: rental.errors.messages }, status: :bad_request
        end
      else
        render json: { errors: "No available inventory for #{movie.title}" }, status: :bad_request
      end
    end
  end

  private
  def rental_params
    return params.require(:rental).permit(:movie_id, :customer_id)
  end

end
