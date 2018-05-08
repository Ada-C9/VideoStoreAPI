class RentalsController < ApplicationController

  # def check_out
  #
  #     rental = Rental.new(rental_params)
  #     if rental.save
  #
  #       if @rental
  #
  #         render json: @rental.as_json(rental.customer_id,rental.video_id),status: :ok
  #
  #       else
  #         render json: {ok: false,errors:"movie not found"}, status: :not_found
  #       end
  #
  # end
  #
  # def check_in
  # end
  #
  #     def rentals_params
  #       return params.permit(:customer_id,:movie_id,:due_date,:checkout_date)
  #     end
end
