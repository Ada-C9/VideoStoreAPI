require "test_helper"

describe RentalsController do
  describe 'check_out' do
    before do
      @old_rental_count = Rental.count
    end

    it 'can create a new rental with good data' do
      rental_data = {
        movie_id: movies(:one).id,
        customer_id: customers(:one).id
      }

      post check_out_path, params: { rental: rental_data }

      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      Rental.find(body['id']).customer_id.must_equal rental_data[:customer_id]
      Rental.count.must_equal @old_rental_count + 1
    end

    it 'returns bad request and error text for bad data' do
      rental_data = {
        movie_id: movies(:one).id,
      }

      post check_out_path, params: { rental: rental_data }

      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include 'errors'
      body['errors'].must_include 'customer_id'

      Rental.count.must_equal @old_rental_count
    end
  end


end
