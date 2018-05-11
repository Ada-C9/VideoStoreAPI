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
      #check that it decreases available_inventory by 1
      # check that it increases customer movie count by 1
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


  describe 'check_in' do
    before do
      @customer = Customer.first
      @movie = Movie.first
      @params = { customer_id: @customer.id, movie_id: @movie.id }
    end

    it 'can find and update a valid rental' do
      post check_out_path, params: @params

      post check_in_path, params: @params

      assert_response :success

      rental = Rental.find_by(@params)
      # binding.pry
      rental.check_in.must_equal Date.today

      # decreases customer movies by 1
      # increases available_inventory by 1
    end

    it 'returns status not_found if rental DNE' do
      bad_params = { customer_id: 21394, movie_id: 4208422 }
      post check_in_path, params: bad_params

      assert_response :not_found
    end

  end
end
