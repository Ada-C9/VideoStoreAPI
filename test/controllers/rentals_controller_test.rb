require "test_helper"

describe RentalsController do

  describe "check_out" do
    let(:rental_data) {
      {
        customer_id: customers(:one).id,
        movie_id: movies(:two).id
      }
    }

    it "creates a rental object" do

      proc {
        post check_out_path(params: rental_data)
      }.must_change 'Rental.count', 1

      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include 'customer_id'
      body['customer_id'].must_equal customers(:one).id
      body.must_include 'movie_id'
      body['movie_id'].must_equal movies(:two).id

    end

    it "returns bad_request with bad params" do
      rental_data[:customer_id] = nil

      proc {
        post check_out_path(params: rental_data)
      }.must_change 'Rental.count', 0

      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include 'ok'
      body['ok'].must_equal false

    end
  end

  describe "check_in" do

  end




end
