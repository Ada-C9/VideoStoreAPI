require "test_helper"

describe RentalsController do
  describe "checkout" do
    it "creates a new rental" do
      old_rentals_count = Rental.count
      movie = Movie.first
      customer = Customer.first
      post checkout_path, params: { movie_id: movie.id, customer_id: customer.id }
      response.header['Content-Type'].must_include 'json'
      must_respond_with :success
      Rental.count.must_equal old_rentals_count + 1
      Rental.last.movie_id.must_equal movie.id
      Rental.last.customer_id.must_equal customer.id
      Rental.last.start_date.must_equal Date.today
      Rental.last.end_date.must_equal Date.today + 7
    end

    it "must respond with bad_request for a movie that DNE" do
      old_rentals_count = Rental.count
      movie_id = Movie.last.id + 1
      customer = Customer.first
      post checkout_path, params: { movie_id: movie_id, customer_id: customer.id }
      response.header['Content-Type'].must_include 'json'
      must_respond_with :bad_request
      Rental.count.must_equal old_rentals_count
    end

    it "must respond with bad_request for a customer that DNE" do
      old_rentals_count = Rental.count
      movie = Movie.first
      customer_id = Customer.last.id + 1
      post checkout_path, params: { movie_id: movie.id, customer_id: customer_id }
      response.header['Content-Type'].must_include 'json'
      must_respond_with :bad_request
      Rental.count.must_equal old_rentals_count
    end

    it "must respond with bad_request for a movie with no available inventory" do
      movie = Movie.first
      customer = Customer.first
      movie.inventory.times do
        Rental.create(movie_id: movie.id, customer_id: customer.id, start_date: Date.today, end_date: Date.today + 7)
      end
      movie.reload
      old_rentals_count = Rental.count

      post checkout_path, params: { movie_id: movie.id, customer_id: customer.id }
      response.header['Content-Type'].must_include 'json'
      must_respond_with :bad_request
      Rental.count.must_equal old_rentals_count
    end
  end # checkout

  describe "checkin" do
    before do
      @rental = Rental.create(movie_id: Movie.first.id, customer_id: Customer.first.id, start_date: Date.today, end_date: Date.today + 7)
    end
    it "should checkin a movie" do

      @rental.return_date.must_be_nil

      post checkin_path, params: { movie_id: @rental.movie_id, customer_id: @rental.customer_id }
      @rental.reload
      @rental.return_date.must_equal Date.today

    end

    it "must respond with not_found for a rental that DNE" do

      movie_id = Movie.last.id + 1
      customer_id = Customer.last.id + 1

      post checkin_path, params: { movie_id: movie_id, customer_id: customer_id}

      response.header['Content-Type'].must_include 'json'
      must_respond_with :not_found

    end
  end
end
