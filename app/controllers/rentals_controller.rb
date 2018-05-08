class RentalsController < ApplicationController

  def check_out
    rental = Rental.new(rental_params)
    rental.check_out = DateTime.now
    rental.due_date = rental.check_out + 7

    movie = Movie.find_by(id: params[:movie_id])
    customer = Customer.find_by(id: params[:customer_id])

    unless movie.inventory_available?
      render json: {
        errors: {
          :available_inventory: ["#{movie.title} is not currently available."]
          }
        }, status: :not_found
    end

    if rental.save
      movie.inventory_check_out
      customer.movie_check_out
      render json: rental.as_json(only: [:movie_id, :customer_id]), status: :ok
    else
      render json: { errors: rental.errors.messages }, status: :bad_request
    end
  end

  def check_in
    rental = Rental.find_by(id: params[:id])



  end

  private
  def rental_params
    return params.require(:rental).permit(:movie_id, :customer_id)
  end

end
