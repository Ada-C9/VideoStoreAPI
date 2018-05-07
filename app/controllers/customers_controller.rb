class CustomersController < ApplicationController
  def index
    customers = Customer.all
    if customers.empty?
      render json: {errors: {
        customer: ["No customers were found"]
      }
    }, status: :not_found

    else
      render json: customers.as_json(only: [:address, :city, :id, :name, :phone, :postal_code, :state]), status: :ok
    end
  end
end
