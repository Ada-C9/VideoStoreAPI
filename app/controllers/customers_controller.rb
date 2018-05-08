class CustomersController < ApplicationController

	def index
		customers = Customer.all

		render json: customers.as_json(only: [:name, :registered_at, :address, :city, :state, :postal_code, :phone]), status: :ok
	end

	def show
		customer = Customer.find_by(id: params[:id])

		if customer.nil?
			render json: {
				errors: {
					id: ["No customer like that found, #{params[:id]}"]
					}
				}, status: :not_found
		else
			render json: customer.as_json(only: [:name, :registered_at, :address, :city, :state, :postal_code, :phone]), status: :ok

		end

	end

end
