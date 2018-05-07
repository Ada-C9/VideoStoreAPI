class CustomersController < ApplicationController
  def index
    customers = Customer.all
    if customers.empty?
      render json: {errors: {
        customer: ["No customers were found"]
      }
    }, status: :not_found

    else
      render json: customers.as_json(only: [:id, :name, :created_at, :phone, :postal_code]), status: :ok
    end
  end
end
