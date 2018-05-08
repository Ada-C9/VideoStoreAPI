require 'pry'
class RentalsController < ApplicationController

  def check_out
    rental = Rental.new(rental_params)
    rental.check_out = DateTime.now
    rental.due_date = rental.check_out + 7

    movie = Movie.find_by(id: params[:rental][:movie_id])

    if movie.nil?
      render json: {
        errors: {
          movie_id: ["No movie with ID #{params[:rental][:movie_id]}"]
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

    if rental.save
      render json: rental.as_json(only: [:movie_id, :customer_id]), status: :ok
    else
      render json: { errors: rental.errors.messages }, status: :bad_request
    end
  end

  def check_in
    rental = Rental.find_rental(params[:rental][:movie_id], params[:rental][:customer_id])

    if rental.nil?
      render json: {
        errors: {
          movie_id: ["No rental is currently checkout with that criteria."]
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
    return params.require(:rental).permit(:movie_id, :customer_id)
  end

end
