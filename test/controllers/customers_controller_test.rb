require "test_helper"

describe CustomersController do
  describe 'index' do
    it 'can list all customers' do
      get customers_path
      must_respond_with :success

      response.header['Content-Type'].must_include 'json'

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      body.length.must_equal Customer.count
    end

    it 'returns customers with exactly the required fields' do
      keys = %w(id name address city state postal_code phone registered_at movies_checked_out_count)
      keys = keys.sort
      get customers_path
      body = JSON.parse(response.body)
      body.each do |customer|
        customer.keys.sort.must_equal keys
      end
    end
  end

  # describe 'show' do
    # it 'can get one customer' do
    #   keys = %w(id name address city state postal_code phone registered_at)
    #
    #   get customer_path
    #   must_respond_with :success
    #
    #   response.header['Content-Type'].must_include 'json'
    #
    #   body = JSON.parse(response.body)
    #   body.must_be_kind_of Hash
    #   body.keys.sort.must_equal keys
    #   body["id"].must_equal customer.id
    # end
  # end


end
