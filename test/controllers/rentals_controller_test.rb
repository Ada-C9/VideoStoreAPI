require "test_helper"

describe RentalsController do

  describe 'checkout' do

    let(:rental_data) {
      {
        movie_id: movies(:one),
        customer_id: customers(:one)
      }
    }

    it "creates a new instance of Rental for a valid movie and customer" do
      old_rental_count = Rental.count

      post checkout_path, params { rental: rental_data }

      must_respond_with :success

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.customer_id.must_equal customers(:one).id
      body.movie_id.must_equal movies(:one).id

      Rental.count.must_equal old_rental_count + 1
    end

    it "sets checkout_date to today and the due date to 7 days later" do
      post checkout_path, params { rental: rental_data }

      must_respond_with :success

      body = JSON.parse(response.body)
      body.checkout_date.must_equal Date.today
      body.due_date.must_equal Date.today + 7
    end

    it "sends bad_request response if movie_id is invalid" do
      bad_rental_data = {
        movie_id: Movie.last.id + 1,
        customer_id: customers(:one)
      }

      post checkout_path, params { rental: bad_rental_data }

      must_respond_with :bad_request

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "movie_id"
    end

    it "sends bad_request response if customer_id is invalid" do
      bad_rental_data = {
        movie_id: movies(:one),
        customer_id: Customer.last.id + 1
      }

      post checkout_path, params { rental: bad_rental_data }

      must_respond_with :bad_request

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "customer_id"
    end

  end


end
