require "test_helper"
require 'pry'
describe RentalsController do

  describe 'check_out' do
    before do
      @customer = Customer.first
      @movie = Movie.first
      @params = { customer_id: @customer.id, movie_id: @movie.id }
    end

    it 'can create a rental with valid info' do
      before_rental_count = Rental.count
      post check_out_path, params: @params
      assert_response :success

      puts @params
      Rental.count.must_equal before_rental_count + 1

      Rental.last.movie_id.must_equal @params[:movie_id]

      Rental.last.customer_id.must_equal @params[:customer_id]
    end

    it "won't create a rental when movie_id DNE" do
      params = { customer_id: @customer.id, movie_id: nil }

      post check_out_path, params: params
      assert_response :bad_request
    end

    it "won't create a rental when customer_id DNE" do

      params = { customer_id: nil, movie_id: @movie.id }
      post check_out_path, params: params
      assert_response :bad_request
    end
  end
end
