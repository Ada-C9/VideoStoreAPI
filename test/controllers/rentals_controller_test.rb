require "test_helper"

describe RentalsController do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end
  describe "check_out" do
    let(:rental_data) {
      {
        customer_id: customers(:one).id,
        movie_id: movies(:one).id
      }
    }

    it "creates a new rental" do
      before_rental_count = Rental.count
      post checkout_url, params: { rental: rental_data }
      must_respond_with :success

      Rental.count.must_equal before_rental_count + 1

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "id"

      Rental.find(body["id"]).customer.id.must_equal rental_data[:customer_id]
      Rental.find(body["id"]).movie.id.must_equal rental_data[:movie_id]
    end
  end
end
