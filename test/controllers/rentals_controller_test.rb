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

    # it "decrements the movie's available_inventory" do
    #   test_movie = movies(:one)
    #   initial_inventory = test_movie.available_inventory
    #
    #   customer_movie_info = {
    #     customer_id: (customers(:one)).id,
    #     movie_id: test_movie.id
    #   }
    #
    #   post rental_path(customer_movie_info)
    #   # movie2 = Movie.find_by(id: movies(:one).id)
    #   # binding.pry
    #
    #   test_movie.available_inventory.must_equal (initial_inventory - 1)
    # end
  end

  describe "update" do
    it "it is a real, working route" do
      rental_count = Rental.all.count
      rental = rentals(:one)

      post rental_update_path(rental.id)

      must_respond_with :success
      Rental.all.count.must_equal rental_count
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
      # customer_movie_info = {
      #   customer_id: customers(:two).id,
      #   movie_id: movies(:one).id
      # }
      # post rental_path(customer_movie_info)
      #
      # body = JSON.parse(response.body)
      # body.length.must_equal 1
      # body["id"].must_equal Rental.last.id
    end

    it "increments the movie's available_inventory" do
      movie = movies(:two)
      starting_available_inventory = movie.available_inventory

      # customer_movie_info = {
      #   customer_id: customers(:one).id,
      #   movie_id: movie.id
      # }
      # post rental_path(customer_movie_info)
      #
      # movie.available_inventory.must_equal (starting_available_inventory + 1)
    end
  end

end
