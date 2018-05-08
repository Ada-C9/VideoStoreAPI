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

    it "Returns an error for an invalid movie ID" do
      bad_data = rental_data.clone()
      bad_data[:movie_id] = Movie.last.id + 1
      assert_no_difference "Rental.count" do
        post check_out_path, params: { rental: bad_data }
        assert_response :not_found
      end

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "movie_id"
    end

    it "Returns an error if movie is not available" do
      post check_out_path, params: { rental: { movie_id: movies(:LOTR).id, customer_id: customers(:kari).id }}
      movies(:LOTR).available_inventory.must_equal 0

      assert_no_difference "Rental.count" do
        post check_out_path, params: { rental: { movie_id: movies(:LOTR).id, customer_id: customers(:dan).id }}
        assert_response :not_found
      end

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "available_inventory"
    end

    it "Returns an error for an invalid customer ID" do
      bad_data = rental_data.clone()
      bad_data[:customer_id] = Customer.last.id + 1
      assert_no_difference "Rental.count" do
        post check_out_path, params: { rental: bad_data }
        assert_response :bad_request
      end

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "customer"
    end
  end

  describe "check_in" do
    let(:rental_data) {
      {
        movie_id: movies(:LOTR).id,
        customer_id: customers(:dan).id
      }
    }

    it "will successfully check in a rental with valid customer and movie id" do
      assert_no_difference "Rental.count" do
        post check_in_path, params: { rental: rental_data }
        must_respond_with :success
      end

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "movie_id"

      # Check that the ID matches
      Rental.find_by(movie_id: body["movie_id"]).movie_id.must_equal movies(:LOTR).id
    end

  end
end
