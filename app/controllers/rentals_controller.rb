class RentalsController < ApplicationController
  def check_out

    movie = Movie.find_by(id: params[:movie_id])

    if movie.available_inventory > 0
      checkout = Date.today.to_s
      due = (Date.today + 7.days).to_s

      @rental = Rental.create(
        checkout_date: checkout,
        due_date: due,
        customer_id: params[:customer_id],
        movie_id: params[:movie_id],
        status: 'checked_out'
      )
      if @rental.save
        # binding.pry
        render json: {customer_id: @rental.customer_id, movie_id: @rental.movie_id}, status: :ok

      else
        render json: {ok: false}, status: :bad_request
      end

    else
      render json: {ok: false}, status: :no_content
    end

  end

  def check_in
    @rental = Rental.find_by(id: params[:id])

    if @rental.nil?
      render json: {ok: false}, status: :bad_request
    else
      @rental.update(status: 'returned')


      render json: {customer_id: @rental.customer_id, movie_id: @rental.movie_id, status: @rental.status}, status: :ok

    end

  end

  private

  def rental_params
    return params.permit(:customer_id, :movie_id)
  end
end
