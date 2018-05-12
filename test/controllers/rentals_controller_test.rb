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
      customer.reload
      count = customer.movies_checked_out_count

      assert_difference "Rental.count", 1 do
        post rentals_check_out_path, params: { movie_id: movie.id, customer_id: customer.id}
      end
      # still need to check if it decreases available inventory
      assert_response :success
      body = JSON.parse(response.body)
      body.keys.sort.must_equal keys
      rental_id = body["id"]
      Rental.find(rental_id).movie.id.must_equal movie.id
      Rental.find(rental_id).customer.movies_checked_out_count.must_equal count + 1
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
    end
  end

  describe 'checkin' do
    let (:rental) { Rental.first }
    let (:movie) { rental.movie }
    let (:movie_three) { movies(:three)}
    let (:unrented_movie) { movies(:one)}
    let (:customer) { rental.customer }

    it "is a real route" do
      post rentals_check_in_url, params: { movie_id: movie.id, customer_id: customer.id }
      must_respond_with :success
    end

    it "returns json" do
      post rentals_check_in_url, params: { movie_id: movie.id, customer_id: customer.id }

      response.header['Content-Type'].must_include 'json'
    end

    it "checks in a movie for a customer" do
      keys = %w(checkout_date due_date id)
      count = customer.movies_checked_out_count
      post rentals_check_in_url, params: { movie_id: movie.id, customer_id: customer.id }

      assert_response :success
      body = JSON.parse(response.body)
      body.keys.sort.must_equal keys
      rental.reload
      rental_id = body["id"]
      Rental.find(rental_id).customer.movies_checked_out_count.must_equal count - 1
    end

    it "should set due_date to nil for rental record" do
      keys = %w(checkout_date due_date id)
      post rentals_check_in_url, params: { movie_id: movie.id, customer_id: customer.id }

      assert_response :success
      body = JSON.parse(response.body)
      body.keys.sort.must_equal keys
      rental.reload
      rental_id = body["id"]
      Rental.find(rental_id).due_date.must_be_nil
    end

    it "does not checkout movie with id that D.N.E." do
      assert_no_difference "Rental.count" do
        post rentals_check_in_url, params: { movie_id: 0000, customer_id: customer.id }

        assert_response :not_found
      end
    end
    it "does not checkout movie if customer id D.N.E" do
      assert_no_difference "Rental.count" do
        post rentals_check_in_url, params: { movie_id: movie.id, customer_id: 0000 }

        assert_response :not_found
      end
    end
    it "renders errors if rental D.N.E." do
      assert_no_difference "Rental.count" do
        post rentals_check_in_url, params: { movie_id: unrented_movie.id, customer_id: customer.id }
        assert_response :not_found
      end
    end
    it "returns rental with most recent due date if same movie and customer" do
      # Arrange/Act
      post rentals_check_out_path, params: { movie_id: movie_three.id, customer_id: customer.id}
      body = JSON.parse(response.body)
      rental_1_id = body["id"]

      customer.reload
      post rentals_check_out_path, params: { movie_id: movie_three.id, customer_id: customer.id}
      body = JSON.parse(response.body)
      rental_2_id = body["id"]

      customer.reload
      count = customer.movies_checked_out_count
      post rentals_check_in_url, params: { movie_id: movie_three.id, customer_id: customer.id }

      Rental.find(rental_1_id).due_date.must_be_nil
      Rental.find(rental_1_id).customer.movies_checked_out_count.must_equal count - 1

    end

  end
end
