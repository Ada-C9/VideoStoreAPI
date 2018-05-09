require "test_helper"
require "pry"

describe RentalsController do
  describe "Index" do
    it "is a real working route" do
      get rentals_path

      must_respond_with :success
    end

    it "returns json" do
      get rentals_path

      response.header['Content-Type'].must_include 'json'
    end

    it "returns an array" do
      get rentals_path

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all rentals" do
      get rentals_path

      body = JSON.parse(response.body)
      body.length.must_equal Rental.count
    end

    it "returns rentals with all fields" do
      keys = %w(checkin_date checkout_date customer_id movie_id)
      get rentals_path

      body = JSON.parse(response.body)
      body.each do |rental|
        rental.keys.sort.must_equal keys
      end
    end
  end

  describe "Show" do
    it "gets a rental" do
      get rental_path(rentals(:one).id)

      must_respond_with :success
    end

    it "returns json" do
      get rental_path(rentals(:one).id)

      response.header['Content-Type'].must_include 'json'
    end

    it "returns a rental hash" do
      get rental_path(rentals(:one).id)

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
    end

    it "returns a 404 for rental not found" do
      rental = rentals(:one)
      rental.destroy
      get rental_path(rental.id)

      must_respond_with :not_found
    end
  end

  describe "Create" do
    let(:rental_data) {
      {
        customer_id: customers(:one).id,
        movie_id: movies(:one).id,
        checkout_date: Date.today
      }
    }

    it "Creates a new rental" do
      proc {
        post checkout_path, params: rental_data
      }.must_change 'Rental.count', 1

      must_respond_with :success
    end

    it "will not create a new rental with bad data" do
      not_a_rental = {
        movie_id: movies(:one).id,
      }

      proc {
        post checkout_path, params: not_a_rental
      }.wont_change 'Rental.count'

      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "ok"
      body["ok"].must_equal false
      body.must_include "errors"
    end
  end

  describe "Update" do

    it "successfully updates an existing rental" do
      existing_rental = rentals(:one)

      proc {
        patch checkin_path(existing_rental),
        params: {
          rental: {
            customer_id: existing_rental.customer_id,
            movie_id: existing_rental.movie_id,
            checkin_date: "2018-05-09",
            checkout_date: "2018-05-04"
          }
        }
      }.wont_change "Rental.count"


      must_respond_with :success

    end

    it "will not update a rental that's already been checked in" do
      existing_rental = rentals(:three)

      # existing_rental.checkin_date = "2018-05-10"
      # existing_rental.customer_id = customers(:two).id
      # existing_rental.movie_id = movies(:two).id
      # existing_rental.save
      # binding.pry

      proc {
        patch checkin_path(existing_rental),
        params: {
          customer_id: existing_rental.customer_id,
          movie_id: existing_rental.movie_id,
          checkin_date: "2018-05-09",
          checkout_date: "2018-05-04"
        }
      }.wont_change "Rental.count"

      must_respond_with :bad_request

    end



  end

end
