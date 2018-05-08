class CustomersController < ApplicationController

  def index
    customers = Customer.all

    customers.each do |customer|
      movies_checked_out_count = customer.movies_checked_out_count
    end

    render json: customers.as_json(only: [:id, :name, :registered_at, :postal_code, :phone, :movies_checked_out_count]), status: :ok
  end
end
