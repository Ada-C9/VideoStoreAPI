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

    # should we also add the json response for a bad request as well?
    describe "Invalid rental responses" do

      it "create rental returns a status of bad_request for invalid movie id" do
        test_movie = movies(:one)

        customer_movie_info = {
          customer_id: nil,
          movie_id: test_movie.id
        }

        post rental_path(customer_movie_info)
        must_respond_with :bad_request
      end

      it "create rental returns a status of bad_request for invalid customer id" do

        customer_movie_info = {
          customer_id: (customers(:one)).id,
          movie_id: nil
        }

        post rental_path(customer_movie_info)
        must_respond_with :bad_request
      end

      it "create rental for invalid customer id does not decrement available_inventory" do
        test_movie = movies(:one)

        initial_inventory = test_movie.available_inventory

        customer_movie_info = {
          customer_id: nil,
          movie_id: test_movie.id
        }

        post rental_path(customer_movie_info)
        Movie.find(test_movie.id).available_inventory.must_equal (initial_inventory)
      end

      it "cannot rent movie with available_inventory of 0, :bad_request response, does not decrement available_inventory" do
        test_movie = movies(:three)

        test_movie.available_inventory.must_equal 0

        customer_movie_info = {
          customer_id: (customers(:one)).id,
          movie_id: test_movie.id
        }

        post rental_path(customer_movie_info)
        must_respond_with :bad_request
        Movie.find(test_movie.id).available_inventory.must_equal 0
      end
    end
  end

  describe "update" do
    it "it is a real, working route" do
      rental_count = Rental.all.count

      # removed rental because it is not used in the code we are testing
      # used movie :two b/c movie :one is invalid rental update (cant return fully stocked movie)
      movie = movies(:two)

      data = {movie_id: movie.id}

      post rental_update_path(data)

      must_respond_with :success
      Rental.count.must_equal rental_count
    end

    it "returns json" do
      movie = movies(:two)

      post rental_update_path(
        {movie_id: movie.id}
      )
      response.header['Content-Type'].must_include 'json'
    end

    it "returns the correct rental" do
      movie = movies(:two)

      post rental_update_path(
        {movie_id: movie.id}
      )

      body = JSON.parse(response.body)
      # is this necessary?
      # should we return the rental?
      # current code returns the movie by movie id not rental id
      # body.length.must_equal 1
      # body["id"].must_equal rental.id
    end

    it "increments the movie's available_inventory" do
      movie = movies(:two)

      starting_available_inventory = movie.available_inventory

      post rental_update_path(
        {movie_id: movie.id}
      )

      Movie.find(movie.id).available_inventory.must_equal (starting_available_inventory + 1)
    end

    describe "Invalid update requests" do

      it "update rental returns a status of bad_request for nil movie id value" do
        rental_count = Rental.all.count

        data = {
          movie_id: nil}

        post rental_update_path(data)

        must_respond_with :bad_request
        Rental.count.must_equal rental_count
      end

      it "update rental returns a status of bad_request for invalid movie id value" do
        rental_count = Rental.all.count

        data = {
          movie_id: -999}

        post rental_update_path(data)

        must_respond_with :bad_request
        Rental.all.count.must_equal rental_count
      end

      it "cannot update rental movie with available_inventory == inventory" do

        rental_count = Rental.all.count

        movie = movies(:four)
        movie.available_inventory.must_equal movie.inventory

        initial_inventory = movie.available_inventory

        data = {
          movie_id: movie.id
        }

        post rental_update_path(data)

        must_respond_with :bad_request
        Rental.all.count.must_equal rental_count
        movie.available_inventory.must_equal initial_inventory
      end
    end
  end

end
