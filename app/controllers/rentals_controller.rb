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

    if movie && customer

      # save rental if valid, otherwise send errors
      if rental.save

        # increase the customer's checked-out movie number
        customer.movies_checked_out_count += 1
        customer.save

        # if the rental custom validations pass, set rental attributes
        # and return rental id and status
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
    movie_id = params[:movie_id].to_i
    customer_id = params[:customer_id].to_i

    # rental = Rental.where(movie_id: movie_id, customer_id: customer_id).where.not(due_date: nil).first

    rental = Rental.where.not(due_date: nil).where(movie_id: movie_id, customer_id: customer_id).order(checkout_date: :desc).first
    # rental = Rental.where(movie_id: movie_id, customer_id: customer_id).order(checkout_date: :desc).where.not(due_date: nil)

    if rental && rental.due_date != nil

      rental.due_date = nil

      unless rental.save
        render json: { errors: rental.errors.messages }, status: :bad_request
        return
      end

      rental.customer.movies_checked_out_count -= 1
      rental.customer.save

      render json: rental.as_json(only: [:id, :checkout_date, :due_date]), status: :ok
    else
      render json: { errors: { rental: ["not found"]}}, status: :not_found
    end
  end
end
