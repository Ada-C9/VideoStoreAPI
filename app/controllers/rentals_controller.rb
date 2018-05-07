class RentalsController < ApplicationController
  def check_out
    rental = Rental.new(rental_params)
    rental.due_date = Date.today + 7

    if rental.save
      render json: rental.as_json(except: [:updated_at], status: :ok)
    else
      render json: {
        errors: rental.errors.messages
      }, status: :bad_request
    end
  end

  private

  def rental_params
    params.require(:rental).permit(:movie_id, :customer_id)
  end
end
