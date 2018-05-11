require 'date'

class RentalsController < ApplicationController

  def check_in
    rental = Rental.find_by(customer_id: rental_params[:customer_id], movie_id: rental_params[:movie_id], check_in_status: false)
    if rental
      rental.update(check_in_status: true)
      render json: { status: 'Success', rental: rental }, status: :ok
    else
      render json: { errors: 'Rental does not exist' }, status: :bad_request
    end
  end

  def check_out
    rental = Rental.new(rental_params)
    rental.checked_out = DateTime.now.to_date
    rental.due_date = rental.checked_out + 7
    rental.check_in_status = false

    if rental.save
      render json: { id: rental.id, movie_id: rental.movie.id, customer_id: rental.customer.id, checked_out_date: rental.checked_out, due_date: rental.due_date }, status: :ok
    else
      render json: { errors: rental.errors }, status: :bad_request
    end
  end

  private

  def rental_params
    return params.permit(:movie_id, :customer_id)
  end

end
