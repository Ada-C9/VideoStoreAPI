class RentalsController < ApplicationController
  def check_out
    checkout = Date.today.to_s
    due = (Date.today + 7.days).to_s

    @rental = Rental.create(
      checkout_date: checkout,
      due_date: due,
      customer_id: params[:customer_id],
      movie_id: params[:movie_id]
    )

    if @rental.save
      render json: {customer_id: @rental.customer_id, movie_id: @rental.movie_id}, status: :ok
    else
      render json: {ok: false}, status: :bad_request
    end
  end

  def check_in

  end

  private

  def rental_params
    return params.permit(:customer_id, :movie_id)
  end
end
