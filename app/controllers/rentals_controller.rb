class RentalsController < ApplicationController

  def checkout

    rental = Rental.new(rental_params)
    rental.checkout_date= Date.today

    rental.due_date= (rental.checkout_date + 7)



    # customer_id = Customer.find_by(id: rental_params[:customer_id])
    # movie_id = Movie.find_by(id: rental_params[:movie_id])


    if rental.save
      #success
      render json: rental_params, status: :ok
    else
      #failure
      render json: {errors: rental.errors.messages }, status: :bad_request
    end

    binding.pry

  end


  def checkin


  end

  private
  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end
