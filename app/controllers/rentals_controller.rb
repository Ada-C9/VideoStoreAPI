require 'date'

class RentalsController < ApplicationController

  def create
    chosen_movie = Movie.find_by(id: params[:movie_id])
      today = Date.today

      rental_data = {
        movie_id: params[:movie_id],
        customer_id: params[:customer_id],
        check_out_date: today.to_s,
        due_date: (today + 7).to_s
      }

      rental = Rental.new(rental_data)

      if rental.save
        Movie.decrement(chosen_movie)
        render json: {id: rental.id}, status: :ok
      else
        render json: {ok: false, errors: rental.errors}, status: :bad_request
      end

  end

  def update
    rental = Rental.find_by(id: params[:rental_id])

    if rental
      today = Date.today.to_s
      rental.check_in_date = today
      rental.save

      Movie.increment(rental.movie)
      render json: {id: rental.id}, status: :ok
    else
      render json: {ok: false, errors: rental.errors}, status: :bad_request
    end
  end

  private

  def rental_params
    return params.permit(:movie_id, :customer_id)
  end
end
