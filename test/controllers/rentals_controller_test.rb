require "test_helper"

describe RentalsController do
  describe "check_out" do
    let(:rental_data) {
      {
        movie_id: movies(:HP).id,
        customer_id: customers(:kari).id
      }
    }

    it "Creates a new rental" do
      assert_difference "Rental.count", 1 do
        post check_out_path, params: { rental: rental_data }
        must_respond_with :success
      end

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "movie_id"

      # Check that the ID matches
      Rental.find_by(movie_id: body["movie_id"]).movie_id.must_equal movies(:HP).id
    end

    it "Returns an error for an invalid rental" do
      bad_data = rental_data.clone()
      bad_data.delete(:movie_id)
      assert_no_difference "Rental.count" do
        post check_out_path, params: { rental: bad_data }
        assert_response :bad_request
      end

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "movie_id"
    end
  end
end
