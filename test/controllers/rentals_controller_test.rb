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
      customer = customers(:one)
      before_movie_check_out = customer.movies_checked_out_count
      post checkout_url, params: { rental: rental_data }
      must_respond_with :success

      Rental.count.must_equal before_rental_count + 1
      customer.reload
      customer.movies_checked_out_count.must_equal before_movie_check_out + 1

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "id"

      Rental.find(body["id"]).customer.id.must_equal rental_data[:customer_id]
      Rental.find(body["id"]).movie.id.must_equal rental_data[:movie_id]
    end

    it "will respond with bad_request if the movie is not available to rent" do
      before_rental_count = Rental.count
      movie = Movie.create(title: "Unavailable", inventory: 1, available_inventory: 0)

      unavailable_data = { customer_id: customers(:one).id, movie_id: movie.id}

      post checkout_url, params: { rental: unavailable_data }

      must_respond_with :bad_request
      Rental.count.must_equal before_rental_count
    end

    it "reduces_available_inventory on movie in the rental" do
      movie = movies(:two)

      before_availability = movie.available_inventory

      available_data = { customer_id: customers(:one).id, movie_id: movies(:two).id }

      post checkout_url, params: { rental: available_data }

      body = JSON.parse(response.body)

      movie.reload

      movie.available_inventory.must_equal before_availability - 1
    end
  end


  describe "check_in" do
    let(:rental_data) {
      {
        customer_id: customers(:one).id,
        movie_id: movies(:two).id
      }
    }
    it "increase_available_inventory on movie in the rental" do
      movie = movies(:two)
      before_availability = movie.available_inventory
      customer = customers(:one)


      available_data = { customer_id: customer.id, movie_id: movies(:two).id }
      post checkout_url, params: { rental: available_data }
      customer.reload
      movie.reload
      before_movie_check_in = customer.movies_checked_out_count
      post checkin_url, params: { rental: available_data }
      customer.reload
      customer.movies_checked_out_count.must_equal before_movie_check_in - 1
      body = JSON.parse(response.body)

      movie.reload

      movie.available_inventory.must_equal before_availability
    end
  end

end
