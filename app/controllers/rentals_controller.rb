class RentalsController < ApplicationController

  def check_out
    customer = Customer.find_by(id: params[:customer_id])
    if customer.nil?
      render json: { ok: false, errors: "invalid customer id"}, status: :not_found
      return
    end
    movie = Movie.find_by(id: params[:movie_id])
    if movie.nil?
      render json: { ok: false, errors: "invalid movid id"}, status: :not_found
      return
    end
    if movie.available_inventory < 1
      render json: { ok: false, errors: "movie not in inventory"}, status: :not_found
      return
    end
    rental = Rental.new(rental_params)
    rental.checkout_date = Date.today
    rental.due_date = Date.today + 7
    movie.inventory -= 1
    if rental.save && movie.save
      render json: rental.as_json(only: [:customer_id, :movie_id, :due_date]), status: :ok
    else
      render json: {ok: false, errors: "could not rent"}, status: :not_found
    end
  end

  def check_in
    rental = Rental.where(customer_id: params[:customer_id], movie_id: params[:movie_id])[0]
    if rental.nil?
      render json: {errors: "rental not found" }, status: :not_found
    else
      rental.movie.inventory += 1
      unless rental.customer.save && rental.movie.save
        render json: {errors: {customer: customer.errors.messages, movie: movie.errors.messages} }, status: :bad_request
      end
      render json: rental.as_json(only: [:customer_id, :movie_id])
      rental.destroy
    end
  end

  private

  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end
