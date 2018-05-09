class CustomersController < ApplicationController
  def index
    if params[:sort]
      @customers = Customer.order(:name)
    else
      @customers = Customer.all
    end
    if @customers.empty?
      render json: {errors: {
        customer: ["No customers were found"]
      }
      }, status: :not_found

    else
      render 'index.json'
    end
  end

end
