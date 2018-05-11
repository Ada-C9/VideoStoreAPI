require "test_helper"

describe CustomersController do
  it "should get index" do
    # Action
    get customers_url

    # Assert
    value(response).must_be :success?
  end

  it "returns json" do
    # Action
    get customers_url

    # Assert
    response.header['Content-Type'].must_include 'json'
  end

  it "returns an Array" do
    # Action
    get customers_url

    # Assert
    body = JSON.parse(response.body)
    body.must_be_kind_of Array
  end

  it "returns all of the customers" do
    # Action
    get customers_url

    # Assert
    body = JSON.parse(response.body)
    body.length.must_equal Customer.count
  end

  it "returns customers with exactly the required fields" do
    # Arrange
    keys = %w(address city id movies_checked_out_count name phone postal_code registered_at state)

    # Action
    get customers_url

    # Arrange
    body = JSON.parse(response.body)

    body.each do |customer|
      # Assert
      customer.keys.sort.must_equal keys
    end
  end

  describe 'Create' do
    let(:customer_data) {
      {
        name: "New Customer",
        phone: "(206) 510-8695",
        address: "Ap #292-5216 Ipsum Rd.",
        city: "Seattle",
        state: "OR",
        postal_code: "24309",
      }
    }

    it "Can create a new customer" do
      # Action / Assert
      proc {
        post customers_path, params: customer_data
      }.must_change 'Customer.count', 1

      # Assert
      assert_response :success
    end

    it "Assigns a registered_at date upon creation" do
      # Action / Assert
      proc {
        post customers_path, params:  customer_data
      }.must_change 'Customer.count', 1

      # Assert
      assert_response :success
      Customer.last.registered_at.to_date.must_equal Customer.last.created_at.to_date
    end

    it 'Returns bad request for bad params data' do
      # Arrange
      customer_data.delete(:name)

      # Assert
      proc {
        post customers_path, params: {customer: customer_data}
      }.wont_change 'Customer.count'

      # Arrange
      body = JSON.parse(response.body)

      # Assert
      must_respond_with :bad_request
      body.must_be_kind_of Hash
      body.must_include "ok"
      body["ok"].must_equal false
      body.must_include "errors"
      body["errors"].must_include "name"
    end
  end

  describe 'Show' do
    it "can get a customer" do
      # Action
      get customer_path(customers(:shelley).id)

      # Assert
      must_respond_with :success
    end

    it "returns a 404 for customers that are not found" do
      # Arrange
      customer = customers(:shelley)
      Rental.destroy_all
      customer.destroy

      # Action
      get customer_path(customer.id)

      # Assert
      must_respond_with :not_found
    end
  end

  describe 'Zomg ' do
    it "should get zomg" do
      # Action
      get zomg_url

      # Assert
      value(response).must_be :success?
    end

    it "returns json" do
      # Action
      get zomg_url

      # Assert
      response.header['Content-Type'].must_include 'json'
    end
  end


end
