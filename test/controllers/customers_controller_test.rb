require "test_helper"

describe CustomersController do
  it "is a real working route" do
    get customers_url

    must_respond_with :success
    response.header['Content-Type'].must_include 'json'
    body = JSON.parse(response.body)
    body.must_be_kind_of Array
  end

  it "returns all of the customers" do
    get customers_url

    body = JSON.parse(response.body)
    body.length.must_equal Customer.count
  end

  it "returns customers with exactly the required fields" do
    
  end

end
