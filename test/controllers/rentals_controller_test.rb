require "test_helper"

describe RentalsController do
  describe "index" do
    it "is a real working route" do
      get rentals_url
      must_respond_with :success
    end

    it "returns json" do
      get rentals_url
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an Array" do
      get rentals_url

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all of the rentals" do
      get rentals_url

      body = JSON.parse(response.body)
      body.length.must_equal Rental.count
    end

    it "returns rentals with exactly the required fields" do
      keys = %w(customer_id due_date id movie_id returned)

      get rentals_url
      body = JSON.parse(response.body)
      body.each do |rental|
        rental.keys.sort.must_equal keys
      end
    end
  end

  describe "show" do
    it "can get a rental" do
      get rental_path(rentals(:rental_one).id)
      must_respond_with :success
    end

    it "returns a 404 for rentals that are not found" do
      rental = rentals(:rental_one)
      rental.destroy
      get rental_path(rental.id)
      must_respond_with :not_found
    end
  end

  describe "create" do
    let(:rental_data) {
      {
        customer_id: customers(:shelley).id,
        movie_id: movies(:blacksmith).id
      }
    }

    it "Creates a new rental" do
      proc {
        post rentals_check_out_path, params: rental_data
      }.must_change 'Rental.count', 1

      must_respond_with :success
    end

    it "returns a bad request for incorrectly creating a rental" do
      rental_data.delete(:customer_id)

      proc {
        post rentals_check_out_path, params: rental_data
      }.must_change 'Rental.count', 0

      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "ok"
      body["ok"].must_equal false
      body.must_include "errors"
      body["errors"].must_include "customer"
    end
  end

  describe "update" do
    let(:rental) {rentals(:rental_one)}

    it "Updates a rental thats is checked-out to be checked-in" do
      post rentals_check_in_path(customer_id: customers(:shelley).id, movie_id: movies(:blacksmith).id)

      rental.returned.must_equal true
    end

    it "Updates a rental thats is checked-in to be checked-out " do
      post rentals_check_out_path(customer_id: customers(:shelley).id, movie_id: movies(:blacksmith).id)

      rental.returned.must_equal false
    end

  end
end
