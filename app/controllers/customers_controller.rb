class CustomersController < ApplicationController
  def index
    customers = Customer.where(name: params[:search])
    render json: customers.as_json(except: [:created_at, :updated_at], status: :ok)
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

  def create
    customer = Customer.new(customer_params)
    if customer.save
      render json: { id: customer.id }, status: :ok
    else
      render json: {
        errors: customer.errors.messages
      }, status: :bad_request
    end
  end

  private
  def customer_params
    return params.require(:customer).permit(:name, :address, :city, :state, :postal_code, :registered_at)
  end
end
