class CustomersController < ApplicationController

  def index
    customers = Customers.all
    render json: @customers.as_json(only: [:name, :registered_at, :address, :city, :state, :postal_code, :phone]), status: :ok
  end

  def zomg
    render json: {"it works"}
  end

end
