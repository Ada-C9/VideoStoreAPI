class CustomersController < ApplicationController
  def index
    customers = Customer.where(name: params[:search])
    render json: customers.as_json(except: [:created_at, :updated_at, :id], status: :ok)
  end

  def show
    customer = Customer.find_by(id: params[:id])

    unless customer
      render json: {errors: {
        id: ["No customer with ID #{params[:id]}"]
      }
      }, status: :not_found
    else

      render json: customer.as_json(except: [:created_at, :updated_at], status: :ok)
    end
  end
end
