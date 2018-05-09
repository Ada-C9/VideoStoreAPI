class RentalsController < ApplicationController

  def checkout
    movie = Movie.find_by(id: params[:rental][:movie_id])
    customer = Customer.find_by(id: params[:rental][:customer_id])
    if movie.nil? || customer.nil?
      render json: { ok: false }, status: :bad_request
    else
      if movie.available_inventory > 0
        rental = Rental.create(movie_id: params[:rental][:movie_id], customer_id: params[:rental][:customer_id], returned?: false)
        if rental
          render json: rental.as_json(), status: :ok
        else
          render json: { ok: false, errors: rental.errors },
          status: :bad_request
        end
      else
        render json: { ok: false}, status: :bad_request # Todo: look up to see if better status
      end
    end
  end

  def checkin
    rental = Rental.find_by(params[:id])
    if rental.nil?
      render json: { ok: false }, status: :no_content
    else
      rental.update(returned?: true)
    end
  end

  private

  def rental_params
    return params.permit(:customer_id, :movie_id)
  end
end
