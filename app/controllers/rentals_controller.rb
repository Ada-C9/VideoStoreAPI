require 'date'

class RentalsController < ApplicationController
  # def new
  #   rental = rental.new
  # end

  def create
    today = Date.today

    cust_mov = {
      customer_id: params[:customer_id],
      movie_id: params[:movie_id],
      check_out_date: today.to_s,
      due_date: (today + 7).to_s
    }

    rental = Rental.new(cust_mov)

    if rental.save
      render json: {id: rental.id}, status: :ok
    else
      render json: {ok: false, errors: rental.errors}, status: :bad_request
    end
  end

  def update
  end

  private

  def rental_params
    return params.permit(:movie_id, :customer_id)
  end
end
