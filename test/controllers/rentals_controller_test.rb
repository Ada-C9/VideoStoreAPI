require "test_helper"
require 'pry'

describe RentalsController do

  describe 'checkout' do

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
      # binding.pry
      must_respond_with :bad_request

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "available inventory"
    end

  end


end
