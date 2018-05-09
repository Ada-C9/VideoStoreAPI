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
    p "top of checkin"
    (Rental.all).each do |rental|
    puts  rental.id
    puts "customerid"
    puts rental.customer_id
    puts "rental id"
    puts      rental.movie_id
      end
    rental = Rental.find_by(id: check_params[:rental_id])
    puts rental.inspect


    rental.checkin_date = DateTime.now
    rental.save
    p "in checkin"
    puts rental.inspect

    movie_id = rental.movie_id
    customer_id = rental.customer_id

    customer = Customer.find_by(id: customer_id)
    movie = Movie.find_by(id: movie_id)

    if rental.save
      p "in rental.save"
      puts rental.inspect
      Customer.find(rental.customer_id).update_attributes movies_checked_out_count:  customer.movies_checked_out_count-1

      Movie.find(rental.movie_id).update_attributes available_inventory: movie.available_inventory+1

      render json: { id: rental.id }, status: :ok
    else
      render json: { errors: rental.errors.messages }, status: :bad_request

    end

  end


  private
  def check_params
    params.permit(:customer_id, :movie_id, :rental_id)
  end
end
