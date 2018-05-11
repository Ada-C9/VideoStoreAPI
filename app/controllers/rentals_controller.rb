require 'pry'

class RentalsController < ApplicationController
  def checkout
    # take in query params
    movie_id = params[:movie_id]
    customer_id = params[:customer_id]

    # find customer and movie by id's
    movie = Movie.find_by(id: movie_id)
    customer = Customer.find_by(id: customer_id)

    checkout_date = Date.today
    due_date = checkout_date + 7

    # initialize a rental

    rental = Rental.new(customer_id: customer_id, movie_id: movie_id, checkout_date: checkout_date, due_date: due_date)
    # head :bad_request unless movie && customer

    if movie && customer
      # save rental if valid, otherwise send errors
      if rental.save
        # if the rental custom validations pass, set rental attributes
        # and return rental id and status

        # increase the customer's checked-out movie number
        customer.movies_checked_out_count += 1
        customer.save

        render json: { id: rental.id }, status: :ok
      else
        # if the rental's custom validations fail, render errors
        # errors come from custom rental validation method (see rental.rb)
        render json: { errors: rental.errors.messages }, status: :bad_request
      end
    else
      render json: {errors: { id: ["Must enter a valid movie and customer"]}}, status: :bad_request
    end


  end

  def checkin
    # take in query params
    movie_id = params[:movie_id]
    customer_id = params[:customer_id]

    # find rental with corresponding attributes
    rental = Rental.find_by(movie_id: params[:movie_id], customer_id: params[:customer_id])

    # set rental due date to nil
    rental.due_date = nil


end
