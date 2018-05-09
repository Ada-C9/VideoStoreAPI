class RentalsController < ApplicationController
  def checkout
    customer = Customer.find_by(id: check_params[:customer_id])
    movie = Movie.find_by(id: check_params[:movie_id])

    if customer.nil?
      render json: {errors: {id: ["No such customer with ID #{check_params[:customer_id]}"]}}, status: :not_found
    elsif movie.nil?
      render json: { errors: { id: ["No such movie with ID #{check_params[:movie_id]}"]}}, status: :not_found
    else
      customer_id = customer.id
      movie_id = movie.id
      checkout_date = DateTime.now
      due_date = checkout_date + 7
      checkin_date = nil

      @rental = Rental.new(customer_id: customer_id, movie_id: movie_id, checkout_date: checkout_date, due_date: due_date, checkin_date: checkin_date)

      if @rental.save
        if customer.movies_checked_out_count == nil
          customer.movies_checked_out_count = 0
          customer.save
        end
        Customer.find(@rental.customer_id).update_attributes movies_checked_out_count:  customer.movies_checked_out_count+1

        Movie.find(@rental.movie_id).update_attributes available_inventory: movie.available_inventory-1
        render :checkout, status: :ok
      else
        render json: {errors: { unknown: ["Something went wrong"]}}, status: :bad_request
      end
    end

  end


  def checkin

    rental = Rental.find(params[:rental_id])
    rental.update_attributes checkin_date: DateTime.now

    customer = Customer.find_by(rental.customer_id)
    movie = Movie.find(rental.movie_id)
    rental = Rental.find_by(id: check_params[:rental_id])
    rental.update_attributes checkin_date: DateTime.now

    if rental.save
      Customer.find(rental.customer_id).update_attributes movies_checked_out_count:  customer.movies_checked_out_count-1

      Movie.find(rental.movie_id).update_attributes available_inventory: movie.available_inventory+1

      render json: { id: rental.id }, status: :ok
    else
      render json: { errors: rental.errors.messages }, status: :bad_request

    end

  end
end

  private
  def check_params
    params.permit(:customer_id, :movie_id, :rental_id)
  end
end
