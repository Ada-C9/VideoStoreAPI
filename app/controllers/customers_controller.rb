class CustomersController < ApplicationController
  def index
    customers = Customer.all

    render json: customers.as_json(only: [:id, :address, :city, :name, :phone, :postal_code, :registered_at])
  end
end
