class RentalController < ApplicationController
  # def check_in
  #
  # end


  def check_out
      movie = Movie.find_by(id: rental_params[:movie_id])
      customer = Customer.find_by(id: rental_params[:customer_id])

      if movie && customer
          rental = Rental.new(movie_id: movie.id, customer_id: customer.id)
        if movie.inventory == 0
            render json:{ok: false, error: "Movie requested is currently out of stock."}
        else
          movie.a_checkout
          rental.assign_check_out_date
          rental.assign_due_date
          if rental.valid?
            render json: rental.as_json(only:[:due_date])
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


  private
  def rental_params
    params.require(:rental).permit(:customer_id, :movie_id)
  end


  end







# def check_out
#   # #this is a modified update/create method
#     if movie && customer
#         rental = Rental.new(movie_id: movie.id, customer_id: customer.id)
#       if movie.inventory == 0
#           render json:{ok: false, error: "Movie requested is currently out of stock."}
#       else
#         movie.a_checkout
#         rental.assign_check_out_date
#         rental.assign_due_date
#         if rental.valid?
#           render json: rental.as_json(only:[:due_date])
#         else
#           render json: {ok: false, error:rental.errors}
#         end
#       end
#     else
#       if movie.nil? && customer.nil?
#         render json:{ok: false, error: "Enter an existing customer ID and movie ID."}
#       elsif customer.nil?
#         render json:{ok: false, error: "Enter an existing customer ID."}
#       elsif movie.nil?
#         render json:{ok: false, error: "Enter an existing movie ID."}
#       end
# end
