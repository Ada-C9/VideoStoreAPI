require 'pry'

class RentalsController < ApplicationController
  def checkout
    # take in query params
    movie_id = params[:movie_id]
    customer_id = params[:customer_id]

    # find customer and movie by id's
    movie = Movie.find_by(id: movie_id)
    customer = Customer.find_by(id: customer_id)

<<<<<<< HEAD
    # change movies_checked_out_count for customer
    # changes available_inventory for movie

    customer.movies_checked_out_count += 1
    customer.save

    checkout_date = Time.now
    due_date = checkout_date + 7

=======
    # initialize a rental
>>>>>>> 5ad83c774d36ba7af42a996498fa5858b2eaf93f
    rental = Rental.new(customer_id: customer_id, movie_id: movie_id, checkout_date: checkout_date, due_date: due_date)

    # save rental if valid, otherwise send errors
    if rental.save
      # if the rental custom validations pass, set rental attributes
      # and return rental id and status
      rental.checkout_date = Date.today
      due_date = checkout_date + 7

      render json: { id: rental.id }, status: :ok
    else
      # if the rental's custom validations fail, render errors
      # errors come from custom rental validation method (see rental.rb)
      render json: { errors: rental.errors.messages }, status: :bad_request
    end

    # increase the customer's checked-out movie number
    customer.movies_checked_out_count += 1
    customer.save

  end

  def checkin
<<<<<<< HEAD
    # know which rental based on params passed in test let block
    @movie = Movie.find_by(id: params[:movie_id])
    @customer = Customer.find_by(id: params[:customer_id])

    # @movie = params[:movie_id]
    # @customer = params[:customer_id]
=======
    # take in query params
    movie_id = params[:movie_id]
    customer_id = params[:customer_id]

    # find rental with corresponding attributes
    rental = Rental.find_by(movie_id: params[:movie_id], customer_id: params[:customer_id])

    # set rental due date to nil 
    rental.due_date = nil

>>>>>>> 5ad83c774d36ba7af42a996498fa5858b2eaf93f

    assign_attributes(@customer)

    before_count = @customer.movies_checked_out_count
    # binding.pry

    # puts "THIS IS MOVIE: #{@customer}"
    puts "BEFORE COUNT: #{before_count}"

    # if @customer.save
    #   @customer.checkin_date = DateTime.now
    # else
    #   # something
    # end

    # add logic for verifying that the checkin date is before the checkout date
  end
end
