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

    new_rental = Rental.new(rental_params)
    new_rental[:checkout] = date
    new_rental[:due_date] = date + 7

    if new_rental.save
      render json: { id: new_rental.id}, status: :ok
      # movie_inventory = Movie.find_by(movie_id).inventory
      # movie_inventory -= 1
    else
       render json: { errors: new_rental.errors.messages }, status: :bad_request
    end
  end
end
