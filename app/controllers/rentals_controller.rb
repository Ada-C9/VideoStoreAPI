require 'date'

class RentalsController < ApplicationController

  def check_out
    rental = Rental.new(rental_params)
    #check movies availability - in a movie method?
    rental.check_out = Date.today
    rental.due_date = Date.today + 7
    #set available_inventory to inventory in movie controller?

    if rental.save
      movie = Movie.find_by(id: rental.movie_id)
      movie.dec_avail_inventory

      render json: { id: rental.id }, status: :ok
    else
      render json: { errors: rental.errors.messages }, status: :bad_request
    end
  end

  def check_in
    rental = Rental.find_by(customer_id: params[:customer_id], movie_id: params[:movie_id])

    if rental.nil?
      render json: {
        "errors": {
          "id": ["No rental with #{params[:id]}"]
        }, status: :not_found
      }
    else
      # logic for increasing available_inventory
      movie = Movie.find_by(id: rental.movie_id)
      movie.inc_avail_inventory
      # logic for increasing available_inventory
      rental.check_in = Date.today
      rental.save

      render(json: rental.as_json(only: [:customer_id, :movie_id]), status: :ok)
    end
  end


  private

  def rental_params
    params.permit(:id, :check_in, :check_out, :due_date, :movie_id, :customer_id)
  end
end
