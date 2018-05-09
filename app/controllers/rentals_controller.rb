class RentalsController < ApplicationController
    # protect_from_forgery with: :null_session

  def checkout
    rental = Rental.create_from_request(rental_params)
    if rental.save
      render json: { id: rental.id }, status: :ok
    else
      render json: {
        errors: rental.errors.messages
        }, status: :bad_request
      end
    end

    def checkin
      rental = Rental.where(rental_params).last

      if rental
        rental.checkin_date = DateTime.now
        if rental.save
          render json: rental.as_json, status: :ok
        else
          render json: {
            errors: rental.errors.messages
          }, status: :bad_request
        end
      else
        render json: {
          errors: {
            rental: ["Rental not found"]
          }
        }, status: :not_found
      end

    end

    private
    def rental_params
      return params.permit(:customer_id, :movie_id)
    end
  end
