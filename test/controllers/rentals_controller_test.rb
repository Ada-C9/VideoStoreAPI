require "test_helper"

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

      amount = customer.movies_checked_out_count

      amount.must_equal 1
    end

    it "available_inventory decreases when checkout is ran" do
      customer = Customer.first
      movie = Movie.first

      pre_inventory = movie.available_inventory

      post check_out_path(customer_id: customer.id, movie_id: movie.id)

      post_inventory = movie.available_inventory

      post_inventory.must_equal pre_inventory - 1
    end

  end

end
