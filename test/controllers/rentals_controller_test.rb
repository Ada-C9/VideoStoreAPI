require "test_helper"

describe RentalsController do
  describe 'checkout' do

    let(:rental_data) {
    {
      customer_id: Customer.first.id,
      movie_id: Movie.first.id
    }
  }
    it 'returns a json object' do
      post new_rental_path, params: rental_data
      response.header['Content-Type'].must_include 'json'
    end

    it 'creates a new rental' do
      proc {
        post new_rental_path("Robots Of Eternity"), params: rental_data
      }.must_change 'Rental.count', 1
      must_respond_with :success

      before_rental_count = Rental.count
      post new_rental_path, params: rental_data
      must_respond_with :success
      Rental.count.must_equal before_rental_count + 1
    end

    it 'does not create a rental with invalid input'  do

      proc {
        post new_rental_path("Robots Of Eternity"), params: { rental: { customer_id: -4 } }
      }.wont_change 'Rental.count'
      must_respond_with :bad_request
    end
  end

  describe 'checkin' do

    let(:rental_data) {
    {
      customer_id: Customer.first.id,
      movie_id: Movie.first.id
    }
  }

    it 'successfully checkin a rental' do

      rental = Rental.new(movie_id: Movie.first.id, customer_id: Customer.first.id, checkout_date: Date.today, due_date: Date.today+7)
      rental.save
      rental.build_rental

      rental.checked_out.must_equal true

      post return_rental_path, params: {movie_id: rental.movie.id, customer_id: rental.customer.id}
      response.header['Content-Type'].must_include 'json'
      rental.reload
      rental.checked_out.must_equal false
    end

    it 'renders an error if rental was not found' do
      movie_id = Movie.last.id+1
      customer_id = Customer.last.id+1

      post return_rental_path, params: { movie_id: movie_id, customer_id: customer_id}

      must_respond_with :not_found
      body = JSON.parse(response.body)
      body.must_include "errors"
    end
  end
end
