require "test_helper"
require 'pry'

describe RentalsController do
  describe "create" do
    it "it is a real, working route" do
      rental_count = Rental.all.count

      customer_movie_info = {
        customer_id: customers(:one).id,
        movie_id: movies(:one).id
      }
      post rental_path(customer_movie_info)

      must_respond_with :success
      Rental.all.count.must_equal (rental_count + 1)
    end

    it "returns json" do
      customer_movie_info = {
        customer_id: customers(:one).id,
        movie_id: movies(:one).id
      }
      post rental_path(customer_movie_info)

      response.header['Content-Type'].must_include 'json'
    end

    it "returns the correct rental" do
      customer_movie_info = {
        customer_id: customers(:one).id,
        movie_id: movies(:one).id
      }
      post rental_path(customer_movie_info)

      body = JSON.parse(response.body)
      body.length.must_equal 1
      body["id"].must_equal Rental.last.id
    end

    it "decrements the movie's available_inventory" do
      test_movie = movies(:one)
      initial_inventory = test_movie.available_inventory

      customer_movie_info = {
        customer_id: (customers(:one)).id,
        movie_id: test_movie.id
      }

      post rental_path(customer_movie_info)
      Movie.find(test_movie.id).available_inventory.must_equal (initial_inventory - 1)
    end
  end

  describe "update" do
    it "it is a real, working route" do
      rental_count = Rental.all.count
      rental = rentals(:one)

      data = {
        customer_id: rental.customer.id,
        movie_id: rental.movie.id}

      post rental_update_path(data)

      must_respond_with :success
      Rental.count.must_equal rental_count
    end

    it "returns json" do
      rental = rentals(:one)

      post rental_update_path(
        {
        customer_id: rental.customer.id,
        movie_id: rental.movie.id}
      )
      response.header['Content-Type'].must_include 'json'
    end

    it "returns the correct rental" do
      rental = rentals(:one)

      post rental_update_path(
        {
        customer_id: rental.customer.id,
        movie_id: rental.movie.id}
      )

      body = JSON.parse(response.body)
      body.length.must_equal 1
      body["id"].must_equal rental.id
    end

    it "increments the movie's available_inventory" do
      rental = rentals(:two)

      starting_available_inventory = rental.movie.available_inventory

      post rental_update_path(
        {
        customer_id: rental.customer.id,
        movie_id: rental.movie.id}
      )

      Movie.find(rental.movie.id).available_inventory.must_equal (starting_available_inventory + 1)
    end
  end

end
