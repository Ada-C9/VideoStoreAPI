class CustomersController < ApplicationController
  def index
    @customers = Customer.request_query(params, Customer)

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
