require 'pry'

class RentalsController < ApplicationController
  def checkout
    customer_id = check_params[:customer_id]
    movie_id = check_params[:movie_id]

    find_customer_and_movie(customer_id, movie_id)

    errors = Rental.check_dependencies(@customer, @movie)

    if errors
      render json: {errors: errors}, status: :not_found
    else

      @rental = Rental.create_checkout(@customer, @movie)

      if @rental.save

        Rental.process_checkout(@customer, @movie)

        render :check, status: :ok

      else
        render json: {errors: { unknown: ["Something went wrong"]}}, status: :bad_request
      end
    end

  end

  def checkin

    customer_id = check_params[:customer_id]
    movie_id = check_params[:movie_id]

    find_customer_and_movie(customer_id, movie_id)

    @rental = find_rental(customer_id, movie_id)

    if @rental.nil?
      render json: {errors: {id: ["No such rental with customer ID #{check_params[:customer_id]} and movie ID #{check_params[:movie_id]}"]}}, status: :not_found
    end

    @rental.checkin_date = DateTime.now

    if @rental.save

      Rental.process_checkin(customer, movie)

      render :check, status: :ok
    else
      render json: { errors: @rental.errors.messages }, status: :bad_request
    end

  end

  private
  def check_params
    params.permit(:customer_id, :movie_id)
  end

  def find_customer_and_movie(customer_id, movie_id)
    @customer = Customer.find_by(id: customer_id)
    @movie = Movie.find_by(id: movie_id)
  end

  def find_rental(customer_id, movie_id)
    @rental = Rental.find_by(customer_id: customer_id, movie_id: movie_id)
  end
end
