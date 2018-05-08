class CustomersController < ApplicationController

  def index
    customers = Customer.all
    render(json: customers.as_json)
  end
end
