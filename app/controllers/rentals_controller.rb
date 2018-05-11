class RentalsController < ApplicationController
  def index
    @rentals = Rental.all
  end

  def show
    @rental = Rental.find_by(id: params[:id])

    if @rental.nil?
      render json: { ok: false, error: :not_found }, status: :not_found
    end
  end

  def create
    movie = Movie.find_by(id: params[:movie_id])

    if movie.available?
      rental = Rental.create(rental_params)

      if rental.valid?
        rental.assign_due_date
        render json: { id: rental.id }, status: :ok
      else
        render json: {ok: false, errors: rental.errors}, status: :bad_request
      end

    else
      render json: {ok: false, errors: "This will not work"}, status: :bad_request
    end
  end

  def update
    rental = Rental.where(customer_id: params[:customer_id]).where(movie_id: params[:movie_id]).find_by(returned: false)

    if rental
      rental.update_attributes(returned: true)
      render json: { id: rental.id }, status: :ok
    else
      render json: { ok: false, errors: "This will not work" }, status: :bad_request
    end
  end

  private

  def rental_params
    return  params.permit(:customer_id, :movie_id)
  end
end
