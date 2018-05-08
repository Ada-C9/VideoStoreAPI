class CustomersController < ApplicationController
  def index
    customers = Customer.where(name: params[:search])
    render json: customers.as_json(except: [:created_at, :updated_at, :id], status: :ok)
  end
end
