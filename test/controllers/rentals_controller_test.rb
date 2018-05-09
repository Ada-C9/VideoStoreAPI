require "test_helper"

describe RentalsController do
  let(:rental_one) { rentals(:rental_one) }
  let(:sara) { customers(:sara) }
  let(:babe) { movies(:babe) }

  describe "checkout" do

    let(:rental_data) {
      {
        movie_id: babe.id,
        customer_id: sara.id,
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
      id = babe.id
      proc {
        post checkout_path, params: {rental: rental_data}
      }.must_change "Rental.count", 1
      must_respond_with :success

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "id"

      # Check that the ID matches
      Rental.find(body["id"]).movie_id.must_equal rental_data[:movie_id]
      babe = Movie.find_by(id: id)
      babe.get_available_inventory.must_equal 1
    end

    it "does not create new Rental if inventory 0" do
      id = babe.id
      babe.inventory = 0
      babe.save
      proc {
        post checkout_path, params: {rental: rental_data}
      }.must_change "Rental.count", 0
      must_respond_with :bad_request

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
    end

    it "returns a bad request for a bad params data" do
      proc {
        post checkout_path, params: {rental: bad_rental_data}
      }.must_change "Rental.count", 0
      must_respond_with :bad_request
    end
  end

  describe "checkin" do

    it "updates a rental when returned" do
      id = rental_one.id
      movie_id = babe.id
      proc {
        post checkin_path(rental_one.id)
      }.must_change "Rental.count", 0
      must_respond_with :success

      rental_one = Rental.find_by(id: id)
      rental_one.returned?.must_equal true
      babe = Movie.find_by(id: movie_id)
      babe.get_available_inventory.must_equal 4
    end

    it "returns a bad request for a non-existent rental" do
      proc {
        post checkin_path(234567890)
      }.must_change "Rental.count", 0
      must_respond_with :no_content
    end

  end

end
