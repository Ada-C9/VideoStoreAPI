class CustomersController < ApplicationController

  def index
    customers = Customer.all

    render json: customers.as_json(methods: :movies_checked_out_count, only: [:id, :name, :registered_at, :postal_code, :phone]), status: :ok
  end
end
