class RentalsController < ApplicationController

  def index
    rentals = Rental.all
    render json: rentals.as_json(only: [:customer_id, :movie_id, :checkin_date, :checkout_date])
  end

  def show
    rental = Rental.find_by(id: params[:id])

    if rental
      render json: rental.as_json(only: [:customer_id, :movie_id, :checkout_date, :checkin_date]), status: :ok
    else
      render json: {ok: false, errors: "Rental not found"}, status: :not_found
    end
  end

  def create
    rental = Rental.create(rental_params)

    if rental.valid?
      render json: { id: rental.id }, status: :ok
    else
      render json: { ok: false, errors: rental.errors }, status: :bad_request
    end
  end

  def update
    rental = Rental.find_by(id: params[:id])

    if rental.checkin_date != nil
      render json: {ok: false, errors: "Rental already checked in."}, status: :bad_request
    elsif rental
      rental.update(checkin_date: params['rental'][:checkin_date])

      render json: rental.as_json(only: [:customer_id, :movie_id, :checkout_date, :checkin_date]), status: :ok
    else
      render json: {ok: false, errors: "Rental not found"}, status: :not_found
    end
  end

  private
  def rental_params
    return params.require(:rental).permit(:customer_id, :movie_id, :checkin_date, :checkout_date)
  end

end
