class CustomersController < ApplicationController

  def index
    @customers = Customer.all
      render :index, status: :ok
  end

  def show
    @customer = Customer.find_by(id: cust_params[:id])
    if @customer.nil?
      render json: {
        errors: {
          id: ["No customer with ID #{cust_params[:id]}"]
        }
      }, status: :not_found
    else
      render :show, status: :ok
    end
  end

  private
  def cust_params
    params.permit(:id)
  end

end
