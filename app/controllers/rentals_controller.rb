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
    rental = Rental.new(rental_params)
    rental.checkout_date = Date.today
    rental.save

    if rental.valid?
      render json: { id: rental.id }, status: :ok
    else
      render json: { ok: false, errors: rental.errors }, status: :bad_request
    end
  end

  def update
    rental = Rental.find_by(customer_id: params[:customer_id], movie_id: params[:movie_id])

    if !rental.valid?
      render json: {ok: false, errors: "Rental not found"}, status: :not_found
    elsif rental.checkin_date != nil
      render json: {ok: false, errors: "Rental already checked in."}, status: :bad_request
    else
      rental.update(checkin_date: params['rental'][:checkin_date])

      render json: rental.as_json(only: [:customer_id, :movie_id, :checkout_date, :checkin_date]), status: :ok
    end
  end

  private
  def rental_params
    return params.permit(:customer_id, :movie_id)
  end

end
