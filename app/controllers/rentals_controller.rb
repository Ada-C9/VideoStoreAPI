class RentalsController < ApplicationController
  def index
    rentals = Rental.all
    render json: rentals.as_json(only: [:customer_id, :movie_id, :checkout_date])
  end

  def show
    rental = Rental.find_by(id: params[:id])

    if rental
      render json: rental.as_json(only: [:customer_id, :movie_id, :checkout_date]), status: :ok
    else
      render json: {ok: false, errors: "Rental not found"}, status: :not_found
    end
  end

  def create
  end
end
