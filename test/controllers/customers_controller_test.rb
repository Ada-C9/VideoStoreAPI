require "test_helper"

describe CustomersController do
  it "should get index" do
    get customers_url
    must_respond_with :success
  end

  it "returns json" do
      get customers_url
      response.header['Content-Type'].must_include 'json'
  end

  it "returns an Array" do
      get customers_url

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
  end

  it "returns all of the customers" do
      get customers_url

      body = JSON.parse(response.body)
      body.length.must_equal Customer.count
  end

  it "returns customers with exactly the required fields" do
      keys = %w(id name phone postal_code)
      get customers_url
      body = JSON.parse(response.body)
      body.each do |customer|
        customer.keys.sort.must_equal keys
      end
  end
end
