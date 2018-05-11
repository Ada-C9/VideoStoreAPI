require "test_helper"

describe CustomersController do

  describe "index" do

    it "is a working route that returns json" do
      get customers_url
      must_respond_with :success
      response.header['Content-Type'].must_include 'json'
    end

    it "returns pets with exactly the required fields" do
      keys = %w(id movies_checked_out_count name phone postal_code registered_at)
      get customers_url
      body = JSON.parse(response.body)
      body.each do |customer|
        customer.keys.sort.must_equal keys
      end
    end

    it "must return nil when 0 customers" do
      Customer.destroy_all
      Customer.all.count.must_equal 0

      get customers_url
      body = JSON.parse(response.body)
      body.empty?.must_equal true
    end

    it "must return one customer when one customer" do
      Customer.destroy_all
      test_customer = Customer.new(name: "Test Name", registered_at: Time.now, address: "123 Main Street", city: "Seattle", state: "WA", postal_code: "98125", phone: "206-123-5555" )
      test_customer.save

      Customer.all.count.must_equal 1

      get customers_url
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      body.length.must_equal 1
    end

    it "must return many customers when many customers" do
      count = Customer.all.count
      count.must_be :>,1

      get customers_url
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      body.length.must_equal count
    end

  end

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
