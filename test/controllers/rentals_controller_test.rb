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

    before do
      rental_data = { movie_id: Movie.first.id, customer_id: Customer.first.id }
      @rental = Rental.create_from_request(rental_data)
      @rental.save
    end

    it "should respond with success" do
      post checkin_path, params: { rental_id: @rental.id }

      must_respond_with :success
    end

    it "should respond with json of rental details" do
      keys = %w(checkin_date checkout_date created_at customer_id due_date id movie_id updated_at)

      post checkin_path, params: { rental_id: @rental.id }

      response.header['Content-Type'].must_include 'json'
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash


      body.keys.sort!.must_equal keys

    end

    it "should respond with bad_request and error text if unable to checkin" do
      rental_id = Rental.last.id + 1

      post checkin_path, params: { rental_id: rental_id}

      must_respond_with :not_found
      response.header['Content-Type'].must_include 'json'
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include 'errors'

    end




  end

end
