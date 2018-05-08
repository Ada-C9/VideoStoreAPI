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
    #
    # let(:checkin_data) {
    #   {
    #     movie_id: rental_one.movie_id,
    #     customer_id: rental_one.customer_id,
    #     returned?: true
    #   }
      # let(:bad_checkin_data) {
      #   {
      #     customer_id: rentals(:rental_two).customer_id,
      #     returned?: true
      #   }
      # }

    it "updates a rental when returned" do
      proc {
        post checkin_path(rental_one.id)
      }.must_change "Rental.count", 0
      must_respond_with :success
      # updated_rental = Rental.find_by(id: rental_one.id)
      rental_one.returned?.must_equal true
    end

    it "returns a bad request for a bad checkin" do
      proc {
        post checkin_path(3437829)
      }.must_change "Rental.count", 0
      must_respond_with :bad_request
    end

  end

end
