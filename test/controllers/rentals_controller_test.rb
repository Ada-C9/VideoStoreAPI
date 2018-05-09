require "test_helper"
require 'pry'

describe RentalsController do
  describe 'checkout' do
    let (:movie) { movies(:one) }
    let (:customer) { customers(:one) }

    it "returns json" do
      post rentals_check_out_path, params: { movie_id: movie.id, customer_id: customer.id}
      response.header['Content-Type'].must_include 'json'
    end

    it "checks out a movie" do
      assert_difference "Rental.count", 1 do
        post rentals_check_out_path, params: { movie_id: movie.id, customer_id: customer.id}
        assert_response :success
      end

    end
  end

  describe 'checkin' do
    let (:movie) { movies(:two) }
    let (:customer) { customers(:two) }

    # it "returns json" do
    #   post rentals_check_in_path
    #   response.header['Content-Type'].must_include 'json'
    # end

    it "checks in a movie for a customer" do
      # Arrange
      available_inventory = movie.available_inventory

      checked_out_count = customer.movies_checked_out_count
      # Act & Assert

      binding.pry

      assert_difference "Rental movie count upon checkin", 1 do
        post :checkin, params: { movie_id: movie.id}
      end
    end
  end
end
