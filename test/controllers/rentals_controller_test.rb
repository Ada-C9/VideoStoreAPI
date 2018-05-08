require "test_helper"

describe RentalsController do
  before do
    @customer = Customer.first
    @movie = Movie.first
  end
  describe "checkout" do
    it "should respond with created" do
      post checkout_path, params: {customer_id: @customer.id, movie_id: @movie.id}

      must_respond_with :created
    end

    it "should respond with rental id given valid data" do
      rental = {
        customer_id: @customer.id,
        movie_id: @movie.id
      }

      post checkout_path, params: rental

      response.header['Content-Type'].must_include 'json'
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include 'id'
      body['id'].must_equal Rental.last.id
    end

    it "should respond with bad_request and error text given invalid data" do
      rental = {
        customer_id: nil,
        movie_id: @movie.id
      }

      post checkout_path, params: rental
      must_respond_with :bad_request


      response.header['Content-Type'].must_include 'json'
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include 'errors'
      body['errors'].must_include 'customer'

    end


  end

  describe "checkin" do
    it "should respond with success" do

    end
  end

end
