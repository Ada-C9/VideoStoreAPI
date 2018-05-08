class RentalsController < ApplicationController

  def check_in
    movie = Movie.find_by(id: params[:movie_id])
    customer = Customer.find_by(id: params[:customer_id])
    new_rental_data = {
      customer_id: customer.id,
      movie_id: movie.id
    }
    rental = Rental.new(new_rental_data)

    if rental.save
      render json: { errors: rental.errors.messages }, status: :bad_request
    else
      render :new
    end
  end

  private
  def rental_params
    params.require(:rental).permit(:movie_id, :customer_id)
  end
end
