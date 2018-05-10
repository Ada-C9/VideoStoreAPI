require "test_helper"
require 'pry'

describe RentalsController do
  # describe 'checkout' do
  #   let (:movie) { movies(:one) }
  #   let (:customer) { customers(:one) }
  #
  #   it "returns json" do
  #     post rentals_check_out_path
  #     response.header['Content-Type'].must_include 'json'
  #   end
  #
  #   it "checks out a movie" do
  #     count = customer.movies_checked_out_count
  #
  #     assert_difference "Rental.count", 1 do
  #       post rentals_check_out_path, params: { movie_id: movie.id, customer_id: customer.id}
  #       assert_response :success
  #     end
  #
  #     customer.movies_checked_out_count.must_equal count + 1
  #   end
  # end

  describe 'checkin' do
    let (:movie_data) { movies(:two) }
    let (:customer_data) { customers(:one) }

    it "returns json" do
      post rentals_check_in_url, params: { movie_id: movie_data.id, customer_id: customer_data.id }
      response.header['Content-Type'].must_include 'json'
    end

    it "checks in a movie for a customer" do
      assert_difference "Rental.count", 1 do
        post rentals_check_in_url, params: { movie_id: movie_data.id, customer_id: customer_data.id }
      end
    end
  end
end
