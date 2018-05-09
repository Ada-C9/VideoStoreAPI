class RentalsController < ApplicationController

  def checkout
    rental = Rental.new(rental_params)
    Rental.rental_date(rental)

    if rental.save
      Rental.build_rental(rental)
      render json: rental_params, status: :ok

    else
      #failure
      render json: {errors: rental.errors.messages }, status: :bad_request
    end
  end


  def checkin
    rental = Rental.find_by(customer_id: params[:customer_id], movie_id: params[:movie_id])
    if rental.nil?
        render json: {
          "errors": {
            "id": ["No rental with id #{params[:id]}"]
          }
          }, status: :not_found
    else
      Rental.build_return(rental)
      render(json: rental.as_json(only: [:customer_id, :movie_id]), status: :ok)
    end
  end

  private
  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end
