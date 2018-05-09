require "test_helper"

describe RentalsController do

  describe 'checkout' do

    let(:rental_data) {
      {
        movie_id: movies(:one).id,
        customer_id: customers(:one).id
      }
    }

    it "creates a new instance of Rental for a valid movie and customer" do
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
      body["errors"].must_include "movie"
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

  end


end
