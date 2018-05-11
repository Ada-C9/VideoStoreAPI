require "test_helper"
require 'pry'

describe RentalsController do
  describe 'checkout' do
    let (:movie) { movies(:one) }
    let (:customer) { customers(:one) }
    let (:rental) { rentals(:one) }

    it "is a real route" do
      post rentals_check_out_path, params: { movie_id: movie.id, customer_id: customer.id}
      must_respond_with :success
    end
    it "returns json" do
      post rentals_check_out_path, params: { movie_id: movie.id, customer_id: customer.id}
      response.header['Content-Type'].must_include 'json'
    end

    it "checks out a movie" do
      keys = %w(id)
      assert_difference "Rental.count", 1 do
        post rentals_check_out_path, params: { movie_id: movie.id, customer_id: customer.id}
      end

      assert_response :success
      body = JSON.parse(response.body)
      body.keys.sort.must_equal keys
      rental_id = body["id"]
      Rental.find(rental_id).movie.id.must_equal movie.id

    end
    it "does not checkout a movie that is not available" do
      movie.reload
      customer.reload
      post rentals_check_out_path, params: { movie_id: movie.id, customer_id: customer.id}

      assert_no_difference "Rental.count" do
        post rentals_check_out_path, params: { movie_id: movie.id, customer_id: customer.id}
        assert_response :bad_request
      end
    end

    it "does not checkout movie with id that D.N.E." do
      assert_no_difference "Rental.count" do
        post rentals_check_out_path, params: { movie_id: 0000, customer_id: customer.id}
        assert_response :bad_request
      end
    end
    it "does not checkout movie if customer id D.N.E" do
      assert_no_difference "Rental.count" do
        post rentals_check_out_path, params: { movie_id: movie.id, customer_id: 0000}
        assert_response :bad_request
      end

  describe 'checkin' do
    let (:movie_data) { movies(:two) }
    let (:customer_data) { customers(:one) }

    # it "returns json" do
    #   post rentals_check_in_url, params: { movie_id: movie_data.id, customer_id: customer_data.id }
    #
    #   response.header['Content-Type'].must_include 'json'
    # end

    it "checks in a movie for a customer" do
      assert_difference "Rental.count", 1 do
        post rentals_check_in_url, params: { movie_id: movie_data.id, customer_id: customer_data.id, due_date: Date }
      end
    end

    it "should set due_date to nil for rental record" do
      r = Rental.where(movie_id: movie_data.id, customer_id: customer_data.id).take
      puts "THIS IS RENTAL #{r}"
      puts r.due_date
      # .wont_be_nil

      post rentals_check_in_url, params: { movie_id: r.id, customer_id: customer_data.id }

      r = Rental.where(movie_id: movie_data.id, customer_id: customer_data.id).take

      r.due_date.must_be_nil

    end
  end
end
