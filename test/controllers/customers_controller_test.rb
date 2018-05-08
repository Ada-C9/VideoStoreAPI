require "test_helper"

describe CustomersController do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end

  describe 'show' do

    it 'can get a customer' do

      keys = %w(address city id name phone postal_code registered_at state)

      customer = customers(:two)
      # Act
      get customer_path(customer.id)

      # Assert
      must_respond_with :success

      response.header['Content-Type'].must_include 'json'
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.keys.sort.must_equal keys
      body["id"].must_equal customer.id
    end

    it 'yields a not_found status and also return some error if the customer DNE' do
      customer_id = Customer.last.id + 1

    get customer_path(customer_id)

    must_respond_with :not_found

    # Check that it sent us some error text
    body = JSON.parse(response.body)
    body.must_be_kind_of Hash
    body.must_include "errors"
    body["errors"].must_include "id"
    end

  end
end
