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
    keys = %w( id movies_checked_out_count name phone postal_code registered_at)

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

  it "returns sorted json when given sort as parameter" do
    get customers_path, params: {sort: "name"}

    must_respond_with :success
    response.header['Content-Type'].must_include 'json'
    body = JSON.parse(response.body)

    body.must_be_kind_of Array

    names = body.map { |customer| customer["name"] }

    sorted_names = names.sort


    sorted_names.must_equal names
  end

  it "returns a maximum number of json records when given n as parameter" do
    #if this doesn't work on implementation try a string for number
    get customers_path, params: {n: "5"}

    must_respond_with :success
    response.header['Content-Type'].must_include 'json'
    body = JSON.parse(response.body)

    body.must_be_kind_of Array
    body.length.must_be :<=, 5
  end

  it "returns a specific page of responses when given p as a parameter" do
    get customers_path, params: {p: "2"}

    must_respond_with :success
    response.header['Content-Type'].must_include 'json'
    body = JSON.parse(response.body)

    body.must_be_kind_of Array
    body.length.must_equal 3
  end

  it "can be successfully combined: /?sort=name&n=10&p=2" do
    get customers_path, params: {sort: "name", n: "10", p: "2"}

    must_respond_with :success
    response.header['Content-Type'].must_include 'json'
    body = JSON.parse(response.body)

    body.must_be_kind_of Array

    names = body.map { |customer| customer["name"] }

    sorted_names = names.sort
    sorted_names.must_equal names
  end
end
