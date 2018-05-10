require 'pry'

class RentalsController < ApplicationController
  def checkout
    movie_id = params[:movie_id]
    customer_id = params[:customer_id]

    movie = Movie.find_by(id: movie_id)
    customer = Customer.find_by(id: customer_id)

    rental = Rental.new(customer_id: customer_id, movie_id: movie_id, checkout_date: checkout_date, due_date: due_date)
    # change movies_checked_out_count for customer
    # changes available_inventory for movie
    if rental.valid?
      # if the rental custom validations pass
      rental.save
      render json: { id: rental.id }, status: :ok
    else
      # if the rental's custom validations fail, render errors
      render json: { errors: rental.errors.messages }, status: :bad_request
    end


    customer.movies_checked_out_count += 1
    customer.save

    checkout_date = Date.today
    due_date = checkout_date + 7
    checkin_date = nil

    rental = Rental.new(customer_id: customer_id, movie_id: movie_id, checkout_date: checkout_date, due_date: due_date)



  end

  def checkin
    # set checkin to a date
  end

end
