class CustomersController < ApplicationController

  def index
    customers = Customer.all
    render json: customers.as_json(only: [:id, :name, :registered_at, :address, :city, :state, :postal_code, :phone])
  end

  def show
    customer = Customer.find_by(id: params[:id])

    if customer
      render json: customer.as_json(only: [:id, :name, :registered_at, :address, :city, :state, :postal_code, :phone]), status: :ok
    else
      render json: { ok: false, errors: "Customer not found" }, status: :not_found
    end
  end

end
