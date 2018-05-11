require 'pry'
class RentalsController < ApplicationController

  def checkout
    movie_id = params[:movie_id]
    customer_id = params[:customer_id]

    date = Date.today
    rental_params = {
      checkout: nil,
      due_date: nil,
      customer_id: customer_id,
      movie_id: movie_id
    }

    movie = Movie.find_by(id: movie_id)
    customer = Customer.find_by(id: customer_id)

    if movie[:inventory] == 0
      render json: {
        errors: {
          inventory: ["Movie is currently all checked out. Sorry."]
        }
      } , status: :bad_request
      return
    end

    new_rental = Rental.new(rental_params)
    new_rental[:checkout] = date
    new_rental[:due_date] = date + 7
    movie[:inventory] -= 1
    if new_rental.save
      movie.save
      render json: { id: new_rental.id}, status: :ok
    else
      render json: { errors: new_rental.errors.messages }, status: :bad_request
    end
  end

  def checkin
    rental = Rental.find_by(params[:id])

    if rental[:checkout].nil? || rental[:due_date].nil?
      render json: {
        errors: {
          checkout: ["Movie has not been checked out."],
        due_date: ["Movie has not been checked out."]
        }
      }, status: :bad_request
      return
    end
    movie = Movie.find_by(rental.movie_id)
    movie[:inventory] += 1
    if movie.save
      render json: { id: movie.id }, status: :ok
    else
      render json: { errors: movie.errors.messages }, status: :bad_request
    end
  end

  private
  def rental_params
    return params.permit(:checkout, :due_date, :customer_id, :movie_id)
  end
end
