require 'date'

class RentalsController < ApplicationController

  # def create
  #   @rental = Rental.new(params)
  #
  #   @rental.check_out = Date.today
  #   @rental.due_date = Date.today + 7
  # end

  def check_out
    # new rental has to have a customer id and a movie id???
    # when you check_out a rental, you create a rental
    # create a new check in date?
    @rental = Rental.new(params)
    #check movies availability - in a movie method?
    @rental.check_out = Date.today
    @rental.due_date = Date.today + 7
    # render json: @rental.as_json(only: [:id, :check_in, :check_out, :due_date])

  end

  def check_in
    # when you check_in a rental, you update a rental
    @rental = Rental.find_by(params)

    @rental.check_in = Date.today
  end

  private

  def rental_params
    return params.require(:rental).permit(:id, :check_in, :check_out, :due_date)
  end  
end
