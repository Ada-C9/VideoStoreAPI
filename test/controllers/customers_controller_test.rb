require "test_helper"

describe CustomersController do
  describe "index" do
    it "returns an array of json" do
      get customers_url
      must_respond_with :success
      response.header['Content-Type'].must_include 'json'
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns customers with a name that matches the search" do
      get customers_url, params: {search: "Bob Esponja"}
      body = JSON.parse(response.body)
      body.each do |customer|
        customer["name"].must_equal "Bob Esponja"
      end
    end

    it "returns customers with exactly the required fields" do
      keys = %w(address city name phone postal_code registered_at state)
      get customers_url, params: {search: "Bob Esponja"}
      body = JSON.parse(response.body)
      body.each do |customer|
        customer.keys.sort.must_equal keys
      end
    end


  end # index
end
