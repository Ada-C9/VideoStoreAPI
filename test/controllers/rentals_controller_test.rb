require "test_helper"

describe RentalsController do

  describe "check out" do

      let(:rental_data) {
        { customer_id: 1,
          movie_id: 1,
          checkout_date: Date.today,
          due_date: Date.today + 7
        }
      }

    it "doesn't create rental without customer_id" do
      rental_data.delete(:customer_id)

      proc {
        post check_out_path, params: rental_data
      }.must_change 'Rental.count', 0

      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "customer_id"
    end

    it "doesn't create rental without movie_id" do
      rental_data.delete(:movie_id)

      proc {
        post check_out_path, params: rental_data
      }.must_change 'Rental.count', 0

      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "movie_id"
    end

    it "doesn't create rental if available inventory is zero" do
      movie = movies(:rocket)
      customer = customers(:ada)

      not_available_data = { customer_id: customer.id,
        movie_id: movie.id,
        checkout_date: Date.today,
        due_date: Date.today + 7
      }

      proc {
        post check_out_path, params: not_available_data
      }.must_change 'Rental.count', 0

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "No copies are currently available"
    end

    it "doesn't create rental if movie doesn't exist" do
      rental_data[:movie_id] = "abc"

      proc {
        post check_out_path, params: rental_data
      }.must_change 'Rental.count', 0

      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"]["movie"].must_equal ["must exist"]
    end

    
  end
end
