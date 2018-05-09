require 'pry'

class RentalsController < ApplicationController
  def checkout
    movie_id = params[:movie_id]
    customer_id = params[:customer_id]

    movie = Movie.find_by(id: movie_id)
    customer = Customer.find_by(id: customer_id)

    # change movies_checked_out_count for customer
    # changes available_inventory for movie

    customer.movies_checked_out_count += 1
    customer.save

    checkout_date = Time.now
    due_date = checkout_date + 7

    rental = Rental.new(customer_id: customer_id, movie_id: movie_id, checkout_date: checkout_date, due_date: due_date)

    if rental.save
      render json: { id: rental.id }, status: :ok
    # else
    #   render json: { errors: rental.errors.messages }, status: :bad_request
    end

  end

  def checkin

  end
end
