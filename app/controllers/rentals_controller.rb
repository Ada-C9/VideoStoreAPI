class RentalsController < ApplicationController
  def checkout
    rental = Rental.new(rental_params)
    rental.start_date = Date.today
    rental.end_date = Date.today + 7
    if rental.save
      render json: {id: rental.id}, status: :ok
    else
      render json: {
        errors: rental.errors.messages
        }, status: :bad_request
      end

    end

    def checkin
      rental = Rental.find_by(id: params[:rental_id])
      unless rental
        render json: {
          errors: {id: ["Invalid rental id"]}
          }, status: :not_found
      else

          rental.return_date = Date.today

          if rental.save
            render json: {id: rental.id}, status: :ok
          end
      end
    end

      private
      def rental_params
        return params.permit(:movie_id, :customer_id)
      end
    end
