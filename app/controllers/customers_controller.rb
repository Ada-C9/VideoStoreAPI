class CustomersController < ApplicationController

  def index
    customers = Customer.all

    render json: customers.as_json(only: [:address, :city, :id, :name, :phone, :postal_code, :registered_at]), status: :ok

    # what if no customers
  end

end
