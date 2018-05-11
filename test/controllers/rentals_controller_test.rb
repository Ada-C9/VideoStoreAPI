require "test_helper"
require 'pry'

describe RentalsController do

  describe 'create' do

    let(:rental_data) {
      {
        movie_id: movies(:one).id,
        customer_id: customers(:one).id
      }
    }

    it "creates a new instance of Rental for a valid customer and a movie that has available inventory" do
      old_rental_count = Rental.count

      post checkout_path, params: { rental: rental_data }

      must_respond_with :success

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "id"
      body.must_include "due_date"

      Rental.count.must_equal old_rental_count + 1
    end

    it "returns new rental's id and due date" do
      keys = %w(due_date id)
      post checkout_path, params: { rental: rental_data }

      body = JSON.parse(response.body)
      body.keys.sort.must_equal keys
    end

    it "sends bad_request response if movie_id is invalid" do
      bad_rental_data = {
        movie_id: Movie.last.id + 1,
        customer_id: customers(:one).id
      }

      post checkout_path, params: { rental: bad_rental_data }

      must_respond_with :bad_request

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "Movie"
    end

    it "sends bad_request response if customer_id is invalid" do
      bad_rental_data = {
        movie_id: movies(:one).id,
        customer_id: Customer.last.id + 1
      }

      post checkout_path, params: { rental: bad_rental_data }

      must_respond_with :bad_request

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "customer"
    end

    it "sends a bad_request if valid movie has no available_inventory" do

      movies(:one).available_inventory = 0

      movies(:one).save

      bad_rental_data = {
        movie_id: movies(:one).id,
        customer_id: Customer.last.id
      }

      post checkout_path, params: { rental: bad_rental_data }
      must_respond_with :bad_request

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "available inventory"
    end

  end

  describe 'update' do

    it "allows a checked out movie to be checked in" do
      rental_data = {
        movie_id: movies(:two).id,
        customer_id: customers(:two).id
      }

      rental = Rental.new(rental_data)
      rental.valid?
      rental.save

      post checkin_path, params: { rental: rental_data }
      must_respond_with :success

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "id"
      body.must_include "check-in date"
    end

    it "does not allow a checked in movie to be checked in again" do
      rental_data = {
        movie_id: movies(:one).id,
        customer_id: customers(:one).id
      }

      rental = Rental.new(rental_data)
      rental.valid?
      rental.save

      rental.updated_at = rental.created_at + 1
      rental.save

      post checkin_path, params: { rental: rental_data }
      must_respond_with :bad_request

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "already checked-in"
    end

    it "does not allow a movie that has not been checked out to be checked in" do
      rental_data = {
        movie_id: movies(:two).id,
        customer_id: customers(:two).id
      }

      post checkin_path, params: { rental: rental_data }
      must_respond_with :bad_request

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "not exist"

    end

  end

end
