require "test_helper"

describe RentalsController do
  describe 'checkout' do
    let (:movie) { movies(:one) }
    let (:customer) { customers(:one) }

    it "returns json" do
      post rentals_check_out_path
      response.header['Content-Type'].must_include 'json'
    end

    it "checks out a movie" do
      count = customer.movies_checked_out_count

      assert_difference "Rental.count", 1 do
        post rentals_check_out_path, params: { movie_id: movie.id, customer_id: customer.id}
        assert_response :success
      end

      customer.movies_checked_out_count.must_equal count + 1
    end
  end

  describe 'checkin' do
    it "text" do
      post  rentals_check_in_path()
    end
  end
end
