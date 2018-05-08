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
      render json: {
        errors: rental.errors.messages
      }, status: :bad_request
    end
  end

  def check_in


  end



  private

  def rental_params
    params.require(:rental).permit(:movie_id, :customer_id)
  end
end
