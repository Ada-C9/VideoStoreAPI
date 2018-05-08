require "test_helper"

describe CustomersController do

  describe 'index' do
    it 'successfully returns JSON containing all the customers' do
      get customers_path

      must_respond_with :success

      response.header['Content-Type'].must_include 'json'

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      body.length.must_equal Customer.count
    end

    it 'returns customers with the required fields' do
      keys = %w(address city created_at id name phone postal_code registered_at state updated_at)

      get customers_path

      body = JSON.parse(response.body)
      body.each do |customer|
        customer.keys.sort.must_equal keys
      end
    end

    it 'returns an empty array if no customers' do
      Customer.all.each do |customer|
        customer.delete
      end

      get customers_path
      body = JSON.parse(response.body)
      body.must_equal []

    end

  end
end
