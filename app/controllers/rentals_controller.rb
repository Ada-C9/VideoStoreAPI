class RentalsController < ApplicationController

  def checkout
    rental = Rental.new(rental_params)
    rental.checkout_date= Date.today
    rental.due_date= (rental.checkout_date + 7)

    if rental.save
      new_inventory = rental.movie.available_inventory -= 1
      #success
      rental.movie.update_attribute(:available_inventory, new_inventory)
      render json: rental_params, status: :ok
    else
      #failure
      render json: {errors: rental.errors.messages }, status: :bad_request
    end
  end


  def checkin
    movie_id = Movie.find_by(id: params[:rental][:movie_id]
    customer_id = Customer.find_by(id: params[:rental][:customer_id])
    rental = Rental.find_by_movie_id_and_customr_id(movie_id, customer_id)

    if rental.nil?
        render json: {
          "errors": {
            "id": ["No rental with id #{params[:id]}"]
          }
          }, status: :not_found
    else
      new_inventory = rental.movie.available_inventory += 1
      rental.movie.update_attribute(:available_inventory, new_inventory)
      render(json: rental.as_json(only: [:customer_id, :movie_id]), status: :ok)
    end
  end

  private
  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end
