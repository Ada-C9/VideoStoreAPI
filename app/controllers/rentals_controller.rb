class RentalsController < ApplicationController

  RENTAL_LIMIT = 7 #days

  def check_out
    rental = Rental.new(rental_params)
    rental.check_out = DateTime.now
    rental.due_date = rental.check_out + RENTAL_LIMIT

    movie = Movie.find_by(id: params[:movie_id])

    unless movie
      render json: {
        errors: {
          movie_id: ["No movie with ID #{params[:movie_id]}"]
        }
      }, status: :not_found
      return
    end

    if movie.available_inventory < 1
      render json: {
        errors: {
          available_inventory: ["#{movie.title} is not currently available."]
          }
        }, status: :not_found
        return
    end

    duplicate_rental = Rental.find_rental(params[:movie_id], params[:customer_id])
    if duplicate_rental
      render json: {
        errors: {
          movie_id: ["#{movie.title} is currently checked out by that customer. A customer may not check out more than one copy of a movie at a time."]
          }
        }, status: :bad_request
        return
    end

    if rental.save
      render json: rental.as_json(only: [:movie_id, :customer_id]), status: :ok
    else
      render json: { errors: rental.errors.messages }, status: :bad_request
    end
  end

  def check_in
    rental = Rental.find_rental(params[:movie_id], params[:customer_id])

    unless rental
      render json: {
        errors: {
          rental: ["There is no outstanding rental with that criteria."]
          }
        }, status: :not_found
        return
    end

    rental.update_attributes(check_in: DateTime.now)

    if rental.save
      render json: rental.as_json(only: [:movie_id, :customer_id]), status: :ok
    else
      render json: { errors: rental.errors.messages }, status: :bad_request
    end
  end

  private
  def rental_params
    return params.permit(:movie_id, :customer_id)
  end
end
