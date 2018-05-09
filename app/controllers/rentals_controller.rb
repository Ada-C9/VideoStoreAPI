class RentalsController < ApplicationController

  def checkout
    rental = Rental.new(rental_params)
    rental.checkout_date= Date.today
    rental.due_date= (rental.checkout_date + 7)

    if rental.save
      new_inventory = rental.movie.available_inventory -= 1
      customer_movie_count = rental.customer.movies_checked_out_count += 1
      #success
      rental.update_attribute(:checked_out, true)
      rental.movie.update_attribute(:available_inventory, new_inventory)
      rental.customer.update_attribute(:movies_checked_out_count, customer_movie_count)
      
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
      new_inventory = rental.movie.available_inventory += 1
      customer_movie_count = rental.customer.movies_checked_out_count -= 1

      rental.update_attribute(:checked_out, false)
      rental.movie.update_attribute(:available_inventory, new_inventory)
      rental.customer.update_attribute(:movies_checked_out_count, customer_movie_count)

      render(json: rental.as_json(only: [:customer_id, :movie_id]), status: :ok)
    end
  end

  private
  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end
