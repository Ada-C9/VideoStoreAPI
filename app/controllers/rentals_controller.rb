class RentalsController < ApplicationController

  def create
    rental = Rental.new(rental_params)

    movie = find_rental_movie(rental_params)
    #cutsomer existence
    if movie.nil?
      render json: {errors: "Movie with id #{rental_params[:movie_id]} doesn't exist"}, status: :bad_request
      return
    end

    if movie.available_inventory == 0
      render json: { errors: "No available inventory for #{movie.title}." }, status: :bad_request
      return
    end

    if rental.save
      movie.decrement_available_inventory
      render json: { id: rental.id, due_date: rental.due_date }, status: :ok
    else
      render json: { errors: rental.errors.messages }, status: :bad_request
    end

  end

  def update
    rental = Rental.find_by(rental_params)
    if rental.nil?
      render json: { errors: "This rental does not exist." }, status: :bad_request
      return
    end

    movie = rental.movie

    #test this & cutsomer existence
    # if movie.nil?
    #   render json: { errors: "Movie with id #{rental_params[:movie_id]} doesn't exist"}, status: :bad_request
    #   return
    # end

    if rental.updated_at != rental.created_at
      render json: { errors: "#{movie.title} is already checked-in." }, status: :bad_request
    else
      if rental.save
        movie.increment_available_inventory
        render json: { id: rental.id, "check-in date": rental.updated_at }, status: :ok
      else
        render json: { errors: rental.errors.messages }, status: :bad_request
      end
    end

  end

  private
  def rental_params
    return params.require(:rental).permit(:movie_id, :customer_id)
  end

  def find_rental_movie(rental_params)
    return Movie.find_by(id: rental_params[:movie_id])
  end

end
