class CustomersController < ApplicationController

  def index
    customers = Customer.all
    render json: customers.as_json(only: [:name, :registered_at, :address, :city, :state, :postal_code, :phone]), status: :ok
  end

  # def zomg
  #   render json: {
  #     "customer": {
  #       "name": "it works"
  #     }
  #   }
  # end

  def show
    customer = Customer.find_by(id: params[:id])
    if customer.nil?
      render json: {
        errors: {
          id: ["No customer with ID #{params[:id]}"]
        }
        }, status: :not_found
      else
        render json: customer.as_json(only: [:name, :registered_at, :address, :city, :state, :postal_code, :phone]), status: :ok
      end
    end

    def create
      customer = Customer.new(customer_params)
      if customer.save
        render json: { id: customer.id }, status: :created
      else
        render json: { errors: customer.errors.messages }, status: :bad_request
      end
    end

    private
    def customer_params
      params.require(:customer).permit(:name, :registered_at, :address, :city, :state, :postal_code, :phone)
    end
  end
