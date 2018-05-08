require 'date'

class RentalsController < ApplicationController

  def index

  end

  def new
    # new rental has to have a customer id and a movie id???
    @rental = Rental.new(params)

    render json: @rental.as_json(only: [:id, :check_in, :check_out, :due_date])
  end

  def check_in
      # when you check_out a rental, you create a rental
  end

  def check_out
      # when you check_in a rental, you update a rental
  end


# private
#
#   def rental_params
#   return params.require(:rental).permit(:id, :check_in, :check_out, :due_date)

end
