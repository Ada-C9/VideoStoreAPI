require "test_helper"

describe RentalsController do
  let(:rental_one) { rentals(:rental_one) }
  let(:sara) { customers(:sara) }
  let(:babe) { movies(:babe) }

  describe "checkout" do

    let(:rental_data) {
      {
        movie_id: babe,
        customer_id: sara,
        checkout_date: Date.today
      }
    }

    let(:bad_rental_data) {
      {
        movie_id: 4567,
        customer_id: 9876,
        checkout_date: Date.today
      }
    }

    it "creates a new Rental" do
      proc {
        post checkout_path, params: {rental: rental_data}
      }.must_change "Rental.count", 1
      must_respond_with :success

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "id"

    # Check that the ID matches
      Rental.find(body["id"]).movie_id.must_equal rental_data[:movie_id]
    end

    it "returns a bad request for a bad params data" do
      proc {
        post checkout_path, params: {rental: bad_rental_data}
      }.must_change "Rental.count", 0
      must_respond_with :bad_request

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "movie_id"
    end
  end

  describe "checkin" do

  end

end
