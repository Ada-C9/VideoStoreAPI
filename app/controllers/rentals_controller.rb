class RentalsController < ApplicationController

  def create
    rental = Rental.new(rental_params)

    if rental.save
      render json: { id: rental.id, due_date: rental.due_date }, status: :ok
    else
      render json: { errors: rental.errors.messages }, status: :bad_request
    end

  end

  private
  def rental_params
    return params.require(:rental).permit(:movie_id, :customer_id)
  end

end
