require "test_helper"

describe CustomersController do
	describe "index" do
		it "responds with success" do
			get customers_path
			must_respond_with :success
		end

		it "returns json" do
			get customers_path
			response.header['Content-Type'].must_include 'json'
		end

		it "returns an array" do
			get customers_path
			body = JSON.parse(response.body)
			body.must_be_kind_of Array
		end

		it "returns all of the customers" do
			get customers_path
			body = JSON.parse(response.body)
			body.length.must_equal Customer.count
		end

		it "returns correct customer fields" do
			keys = %w(address city name phone postal_code registered_at state)

			get customers_path
			body = JSON.parse(response.body)

			body.each do |customer|
				customer.keys.sort.must_equal keys
			end
		end
	end

	describe "show" do
		it "returns " do
			keys = %w(address city name phone postal_code registered_at state)
			customer = customer(:one)

			get customer_path(customer.id)

			body = JSON.parse(response.body)

		end
	end
end
