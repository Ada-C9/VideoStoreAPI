require "test_helper"

describe CustomersController do
  describe 'index' do
    it 'is a working route that sends json' do
      get customers_url

      must_respond_with :success
      response.header['Content-Type'].must_include 'json'
    end

    it 'returns an Array of all the customers' do
      get customers_url

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      body.length.must_equal Customer.count
    end

    it 'returns customers with exactly the required fields' do
      keys = %w(address city id movies_checked_out_count name phone postal_code registered_at state)

      get customers_url

      body = JSON.parse(response.body)
      body.each do |customer|
        customer.keys.sort.must_equal keys
      end
    end
  end
end
