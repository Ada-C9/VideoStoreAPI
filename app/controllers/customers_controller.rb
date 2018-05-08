class CustomersController < ApplicationController
  def index
    customers = Customer.all
    render json: customers.as_json(only:[:id,:name,:registers_at,:postal_code,:phone,:methods=>[:movies_checked_out_count]])
  end
end
