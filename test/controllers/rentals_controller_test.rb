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

      puts "before availability #{before_availability}"

      available_data = { customer_id: customers(:one).id, movie_id: movies(:two).id }

      post checkout_url, params: { rental: available_data }

      body = JSON.parse(response.body)

      puts "body: #{body}"


      puts movie.title
      movie.reload

      puts "movie availability after post: #{movie.available_inventory}"
      movie.available_inventory.must_equal before_availability - 1
    end
  end


  describe "check_in" do
    let(:rental_data) {
      {
        customer_id: customers(:one).id,
        movie_id: movies(:one).id
      }
    }
    it "increase_available_inventory on movie in the rental" do
      movie = movies(:one)
      before_availability = movie.available_inventory

      puts "before availability #{before_availability}"

      available_data = { customer_id: customers(:one).id, movie_id: movies(:two).id }
      # post checkout_url, params: { rental: available_data }
      # movie.reload
      post checkin_url, params: { rental: available_data }

      body = JSON.parse(response.body)

      puts "body: #{body}"


      puts movie.title
      movie.reload

      puts "movie availability after post: #{movie.available_inventory}"
      movie.available_inventory.must_equal before_availability + 1
    end
  end

end
