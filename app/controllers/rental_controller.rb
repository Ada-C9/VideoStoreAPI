class RentalController < ApplicationController
  def check_in

  end


  def check_out
    movie = Movie.find_by(id: params[:movie_id])
    customer = Customer.find_by(id: params[:customer_id])
    if movie && customer
      rental = Rental.new(movie_id: movie.id, customer_id: customer.id)
      if movie.available_inventory == 0
        render json:{ok: false, error: "Movie requested is currently out of stock."}
      else
        movie.a_checkout
        customer.add_to_check_out_count
        rental.assign_check_out_date
        rental.assign_due_date
        if rental.save
          # render json: rental.as_json(only:[:due_date])
           render json: movie.as_json(only:[:available_inventory])
        else
          render json: {ok: false, error:rental.errors}
        end
      end
    else
      if movie.nil? && customer.nil?
        render json:{ok: false, error: "Enter an existing customer ID and movie ID."}
      elsif customer.nil?
        render json:{ok: false, error: "Enter an existing customer ID."}
      elsif movie.nil?
        render json:{ok: false, error: "Enter an existing movie ID."}
      end
    end
  end


end
