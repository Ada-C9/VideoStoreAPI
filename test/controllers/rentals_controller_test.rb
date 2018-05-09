require "test_helper"

describe RentalsController do
  before do
    movie = Movie.first
    customer = Customer.first
    @date = Date.today

    @rental_data = {
      checkout: nil,
      due_date: nil,
      customer_id: customer.id,
      movie_id: movie.id
    }

  end

  describe 'checkout' do
    it 'is real route' do
      post checkout_path, params: @rental_data

      must_respond_with :success
    end

    it 'can checkout a movie' do
      before_count = Rental.count

      # Act
      post checkout_path, params: @rental_data

      assert_response :success
      Rental.count.must_equal before_count + 1

      body = JSON.parse(response.body)
      body.must_include "id"
      new_rental = Rental.find(body["id"])

      new_rental.customer_id.must_equal @rental_data[:customer_id]

      new_rental.movie_id.must_equal @rental_data[:movie_id]

      new_rental.checkout.must_equal @date

      new_rental.due_date.must_equal @date + 7
    end

    it 'changes inventory of movie with creation of a new checkout' do
      skip
    end

    it 'throws an error if inventory of movie is 0 and someone tries to checkout' do
      skip
    end
  end

  # describe 'checkin' do
  #   it 'is real route' do
  #     skip
  #   end
  #
  #   it 'can checkin a movie' do
  #     skip
  #   end
  #
  #   it 'changes the inventory of movie when it is checked in' do
  #     skip
  #   end
  #
  #   it 'throws an error if a movie is not checked out and you attempt a checkin' do
  #     skip
  #   end
  # end
end
