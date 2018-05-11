require 'date'

class RentalsController < ApplicationController

  def create
    movie_id_params = params[:movie_id]
    customer_id_params = params[:customer_id]

    chosen_movie = Movie.find_by(id: movie_id_params)
    today = Date.today

    rental_data = {
      movie_id: movie_id_params,
      customer_id: customer_id_params,
      check_out_date: today.to_s,
      due_date: (today + 7).to_s
    }

    rental = Rental.new(rental_data)

    # I added this check to confirm that the movie is available to save before we make a new rental
    # called the movie.available_movie? to

    if movie_id_params.nil? || customer_id_params.nil?
      # this renders multiple times so I commented it out
      # I'm unsure why its rendering multiple times
      # I set this up to send a bad request/not_found for nil values for ids in params and also test if movie can be rented

      # render json: {ok: false }, status: :not_found
    else
      chosen_movie = Movie.available_movie?(chosen_movie.id)
    end

    if chosen_movie && rental.save
      Movie.decrement(chosen_movie)
      render json: {id: rental.id}, status: :ok
    else
      render json: {ok: false, errors: rental.errors}, status: :bad_request
    end

  end

  def update
    # changed the test to return not_found and account for nil passed in params and invalid id passed in params

    if params[:movie_id].nil?
      # accounts for nil value and only sends a single bad render status
      rental_movie = nil
    else
      rental_movie = Movie.find_by(id: params[:movie_id])
    end

    if rental_movie
      Movie.increment(rental_movie)
      render json: {id: rental_movie.id}, status: :ok
    elsif rental_movie.nil?
      render json: {ok: false}, status: :bad_request
    else
      render json: {ok: false, errors: rental_movie.errors}, status: :bad_request
    end
  end

  # rental = Rental.find_by(id: params[:rental_id])
  #
  # if rental
  #   today = Date.today.to_s
  #   rental.check_in_date = today
  #   rental.save
  #
  #   Movie.increment(rental.movie)
  #   render json: {id: rental.id}, status: :ok
  # else
  #   render json: {ok: false, errors: rental.errors}, status: :bad_request
  # end


  private

  def rental_params
    return params.permit(:movie_id, :customer_id)
  end
end
