require "test_helper"

describe CustomersController do
  describe "index" do
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

    it "returns an empty array when there are no customers" do

    end
  end

  describe "show" do
    it "can get a customer" do
      get customer_path(customers(:one).id)

      must_respond_with :success
    end

    it "returns the customer info for the selected customer" do
      get customer_path(customers(:one).id)

      body = JSON.parse(response.body)

      body.must_be_kind_of Hash
      body["phone"].must_equal customers(:one).phone
    end

    it "returns not_found when the customer DNE" do
      not_real_customer_id = Customer.last.id + 1

      get customer_path(not_real_customer_id)

      must_respond_with :not_found

      #assert for whatever we are putting for the body response message with not found
    end
  end

  describe "create" do
    #like let(:pet_data)

    it "creates a new customer" do

    end

    it "returns an error for an invalid customer" do

    end

  end
end
