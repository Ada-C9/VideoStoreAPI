require "test_helper"
require 'pry'

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
		it "returns a single customer" do
			keys = %w(address city name phone postal_code registered_at state)
			customer = customers(:one)

			get customer_path(customer.id)

			response.header['Content-Type'].must_include 'json'
			body = JSON.parse(response.body)
			body.must_be_kind_of Hash
			body.keys.sort.must_equal keys
			body["name"].must_equal customer.name
			must_respond_with :success
		end
		it "provides an error message if customer not found" do
			customer_id = Customer.last.id + 1
			get customer_path(customer_id)

			response.header['Content-Type'].must_include 'json'
			body = JSON.parse(response.body)
			body.must_be_kind_of Hash
			body.must_include "errors"
			body["errors"].must_include "id"
			must_respond_with :not_found
		end
	end
	describe 'create' do
		let(:customer_data) {
			{
				name: "Name",
				address: "Some address",
				city: "City",
				state: "State",
				postal_code: "123456",
				phone: "000-000-0000",
				registered_at: "2018-05-09"
				}
			}

		it "creates a customer" do
			assert_difference "Customer.count", 1 do
				post customer_path, params: {customer: customer_data}
				assert_response :success
			end
		end
	end
end
