class RentalController < ApplicationController
  # def check_in
  #
  # end

  def check_out
    #this is a modified update/create method
    movie = Movie.find_by(id: rental_params[:movie_id])
    customer = Customer.find_by(id: rental_params[:customer_id])
    #they've found the movie and customer exists.
    if movie.nil?
      render json:{ok: false, error: "provide an existing movie ID."}
    end
    if customer.nil?
      render json:{ok: false, error: "provide an existing customer ID."}
    end

      rental = Rental.new(movie_id: movie.id, customer_id: customer.id)
      if movie.inventory == 0
          render json:{ok: false, error: "Moive requested is currently out of stock."}
      else
        movie.a_checkout
        rental.assign_check_out_date
        rental.assign_due_date
      end

      if rental.valid?
        render json: rental.as_json(only:[:due_date])
      else
        render json:{ok: false, error: rental.errors}
      end
  end

  private
  def rental_params
    params.require(:rental).permit(:customer_id, :movie_id)
  end


  # def check_out
  #     rental = Rental.where(customer_id: rental_params[:customer_id], movie_id: rental_params[:movie_id]).sort.first.assign_due_date
  #     if rental.nil?
  #       render(
  #       json: {errors: ["Rental not found"]},
  #       status: :not_found
  #       )
  #       return
  #     else
  #       rental.check_in_date = Date.today
  #       if rental.save
  #         rental.movie.a_checkin
  #         render(
  #         json: {id: rental.id},
  #         status: :ok
  #         )
  #       else
  #         render(
  #         json: {errors: rental.error.messages},
  #         status: :bad_request
  #         )
  #       end
  #     end
  #   end

    private
    def rental_params
      params.require(:rental).permit(:customer_id, :movie_id, :assign_checkout_date, :assign_due_date)
    end


end
