require "test_helper"

describe CustomersController do
  it "should get index" do
    get customers_path

    must_respond_with :success
  end

  it "returns json with collection of customers" do
    get customers_path

    response.header['Content-Type'].must_include 'json'

    body = JSON.parse(response.body)

    body.must_be_kind_of Array
    body.length.must_equal Customer.count
  end

  it "returns with the exact fields required" do
    keys = %w(address city id name phone postal_code state)

    get customers_path
    body = JSON.parse(response.body)

    body.each do |customer|
      customer.keys.sort!.must_equal keys
    end
  end

  it "returns no content when no available customers" do
    Customer.destroy_all

  Customer.count.must_equal 0

    get customers_path

    must_respond_with :not_found
    puts "Here is the response body: #{response.body}"
    body = JSON.parse(response.body)
    body.must_be_kind_of Hash
    body.must_include "errors"

    body["errors"].must_include "customer"
  end

end
