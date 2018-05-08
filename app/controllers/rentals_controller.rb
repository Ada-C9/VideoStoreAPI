class RentalsController < ApplicationController
  def checkout
    rental = Rental.create_from_request(params)
    if rental.save
      render json: { id: rental.id }, status: :created
    else
      render json: {
        errors: rental.errors.messages
        }, status: :bad_request
      end
    end

    def checkin
      rental = Rental.find_by(id: params[:rental_id])

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
  end
