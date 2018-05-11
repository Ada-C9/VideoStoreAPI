class RentalsController < ApplicationController

  def create
    rental = Rental.new(rental_params)

    movie = Movie.find_by(id: rental_params[:movie_id])
    customer = Customer.find_by(id: rental_params[:customer_id])

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
      customer.increment_movies_checked_out_count
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
    customer = rental.customer

    if rental.updated_at != rental.created_at
      render json: { errors: "#{movie.title} is already checked-in." }, status: :bad_request
    else
      if rental.save
        movie.increment_available_inventory
        customer.decrement_movies_checked_out_count
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

end
