class RentalsController < ApplicationController

  def checkout
    customer_id = params[:customer_id]
    rental = Rental.new(rental_params)
    rental.start_date = Date.today
    rental.end_date = Date.today + 7

    if rental.save
      customer = Customer.find_by(id: customer_id)
      customer.movies_checked_out_count += 1
      customer.save
      render json: {id: rental.id}, status: :ok
    else
      render json: {
        errors: rental.errors.messages
        }, status: :bad_request
    end
  end # checkout

  def checkin
    rental = Rental.find_by(movie_id: params[:movie_id], customer_id: params[:customer_id])

    unless rental
      render json: {
        errors: {
          id: ["Invalid rental id"]
        }
      }, status: :not_found
    else
      rental.return_date = Date.today
      if rental.save
        customer = Customer.find_by(id: rental.customer_id)
        customer.movies_checked_out_count -= 1
        customer.save
        render json: {id: rental.id}, status: :ok
      end
    end
  end # checkin

  private
  def rental_params
    return params.permit(:movie_id, :customer_id)
  end

end # RentalsController
