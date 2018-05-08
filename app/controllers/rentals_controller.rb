class RentalsController < ApplicationController
  def check_out
    rental = Rental.new(rental_params)
    rental.due_date = Date.today + 7

    if rental.save
      new_inventory = rental.movie.available_inventory - 1
      movie = Movie.find(rental.movie_id)
      movie.update(available_inventory: new_inventory)
      render json: rental.as_json(except: [:updated_at], status: :ok)
    else
      render json: { errors: rental.errors.messages}, status: :bad_request
    end
  end

  def check_in
    rental = Rental.find_checked_out_movie(params[:movie_id], params[:customer_id])
    if rental
      rental.update(check_in_date: Date.today)
      new_inventory = rental.movie.available_inventory + 1
      movie = Movie.find(rental.movie_id)
      movie.update(available_inventory: new_inventory)
      render json: rental.as_json(except: [:updated_at], status: :ok)
    else
      render json: {
        errors: {
          rental: ["No rental found"]
        }
      }, status: :not_found
    end

  end



  private

  def rental_params
    params.permit(:movie_id, :customer_id)
  end
end
