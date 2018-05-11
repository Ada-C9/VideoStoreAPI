require "test_helper"
require "Date"

describe RentalsController do
  describe "checkout" do
    it "can checkout a valid movie" do

    end

    it "can't checkout an invalid movie" do

    end

    it "creates a new rental" do

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

      bad_data = url_data.delete(:movie_id)

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
