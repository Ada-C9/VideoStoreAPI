class CustomersController < ApplicationController

  def index
    customers = Customer.all
    render json: customers.as_json, status: :ok
  end

end
