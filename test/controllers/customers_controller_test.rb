require "test_helper"
require "pry"

describe CustomersController do
  it "should get index" do
    get customers_url
    must_respond_with :success
  end

  it "should still return success if there are no customers" do
    Customer.destroy_all
    Customer.count.must_equal 0
    get customers_url
    must_respond_with :success
  end

  it "should return json" do
    get customers_url
    response.header['Content-Type'].must_include "json"
  end

  it "should return an array" do
    get customers_url
    body = JSON.parse(response.body)
    body.must_be_kind_of Array
  end

  it "returns all of the customers" do
    get customers_url

    body = JSON.parse(response.body)
    body.length.must_equal Customer.count
  end








end
