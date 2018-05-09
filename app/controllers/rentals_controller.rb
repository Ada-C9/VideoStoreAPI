class RentalsController < ApplicationController

  def checkout
    rental = Rental.new(rental_params)
    rental.checkout_date= Date.today
    rental.due_date= (rental.checkout_date + 7)

    if rental.save
      #success
      rental.movie.available_inventory.update(available_inventory: (rental.movie.available_inventory - 1))
      render json: rental_params, status: :ok

      binding.pry
    else
      #failure
      render json: {errors: rental.errors.messages }, status: :bad_request
    end
  end


  def checkin
    rental = Rental.find_by(id: parmas[:id])
    if rental.nil?
        render json: {
          "errors": {
            "id": ["No rental with id #{params[:id]}"]
          }
          }, status: :not_found
    else
      rental.movie.available_inventory += 1
      render(json: rental.as_json(only: [:customer_id, :movie_id]), status: :ok)

    end
  end

  private
  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end
