class CustomersController < ApplicationController

  def index
    customers = Customer.all
    render json: customers.as_json(only: [:name, :registered_at, :address, :city, :state, :postal_code, :phone]), status: :ok
  end

  # def zomg
  #   render json: {
  #     "customer": {
  #       "name": "it works"
  #     }
  #   }
  # end

end
