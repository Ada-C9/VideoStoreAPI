require "test_helper"
require "Date"

describe RentalsController do
  describe "checkout" do
    it "can post to the checkout path w/ valid movie" do
      customer_id = Customer.first.id
      movie_id = Movie.first.id

      pre_count = Rental.all.count

      post check_out_path(customer_id:customer_id, movie_id: movie_id)
      must_respond_with :ok

      post_count = Rental.all.count
      post_count.must_equal pre_count + 1
    end

    it "can't post to the checkout path w/ invalid customer" do
      customer_id = Customer.last.id + 1
      movie_id = Movie.first.id

      pre_count = Rental.all.count

      post check_out_path(customer_id:customer_id, movie_id: movie_id)
      must_respond_with :not_found

      post_count = Rental.all.count
      post_count.must_equal pre_count

      body = JSON.parse(response.body)
      body.must_include "errors"
      body["errors"]["id"].must_equal ["No such customer with ID #{customer_id}"]
    end

    it "can't post to the checkout path w/ invalid movie" do
      customer_id = Customer.first.id
      movie_id = Movie.last.id + 1

      pre_count = Rental.all.count

      post check_out_path(customer_id:customer_id, movie_id: movie_id)
      must_respond_with :not_found

      post_count = Rental.all.count
      post_count.must_equal pre_count

      body = JSON.parse(response.body)
      body.must_include "errors"
      body["errors"]["id"].must_equal ["No such movie with ID #{movie_id}"]
    end

    it "movies_checked_out_count increases when checkout is ran" do
      customer = Customer.first
      movie = Movie.first

      post check_out_path(customer_id: customer.id, movie_id: movie.id)

      customer.reload
      amount = customer.movies_checked_out_count

      amount.must_equal 1
    end

    it "available_inventory decreases when checkout is ran" do
      customer = Customer.first
      movie = Movie.first

      pre_inventory = movie.available_inventory

      post check_out_path(customer_id: customer.id, movie_id: movie.id)

      movie.reload
      post_inventory = movie.available_inventory

      post_inventory.must_equal pre_inventory - 1
    end

  end

  describe "checkin" do

    customer_id = Customer.first.id
    movie_id = Movie.first.id

    url_data = {
      customer_id: customer_id,
      movie_id: movie_id
    }

    it "responds with success" do

      post check_out_url, params: url_data
      post check_in_url, params: url_data
      must_respond_with :success
    end

    it "returns json" do
      post check_out_url, params: url_data
      post check_in_url, params: url_data
      response.header['Content-Type'].must_include 'json'
    end

    it "update checkin field on valid rental" do

      post check_out_url, params: url_data
      post check_in_url, params: url_data

      rental = Rental.find_by(customer_id: url_data[:customer_id], movie_id: url_data[:movie_id])
      rental.checkin_date.must_equal DateTime.now
    end

    it "does not checkin an invalid rental" do
      url_data[:movie_id].delete


      bad_data = {
        customer_id: customer_id,
        movie_id: movie_id
      }

      post check_out_url, params: url_data
      post check_in_url, params: bad_data

      must_respond_with :bad_request


    end

    it "updates movies_checked_out_count field for customer and available_inventory for movie associated with rental" do

      post check_out_url, params: url_data
      customer = Customer.find_by(id: url_data[:customer_id])
      movie = Movie.find_by(id: url_data[:movie_id])
      after_checkout_cust = customer.movies_checked_out_count
      after_checkout_movie = movie.available_inventory

      post check_in_url, params: url_data

      customer = Customer.find_by(id: url_data[:customer_id])
      movie = Movie.find_by(id: url_data[:movie_id])

      customer.movies_checked_out_count.must_equal after_checkout_cust - 1
      movie.available_inventory.must_equal after_checkout_movie + 1

    end
  end



end
