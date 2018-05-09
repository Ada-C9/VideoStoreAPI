require "test_helper"

describe RentalsController do
  describe "check_out" do
    let(:rental_data) {
      {
        customer_id: customers(:one).id,
        movie_id: movies(:two).id
      }
    }

    it "creates a rental object and returns customer_id and movie_id in request body if given valid params and available inventory is > 0" do
      proc {
        post check_out_path(params: rental_data)
      }.must_change 'Rental.count', 1

      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include 'customer_id'
      body['customer_id'].must_equal customers(:one).id
      body.must_include 'movie_id'
      body['movie_id'].must_equal movies(:two).id
    end

    it "decreases the movie's available inventory if given valid params and available inventory is > 0" do
      movie_two = movies(:two)
      ai = movie_two.available_inventory

      post check_out_path(params: rental_data)

      movie_two = Movie.find_by(id: movie_two.id)
      movie_two.available_inventory.must_equal ai - 1
    end

    it "increases the customer's movies checked out count if given valid params and available inventory is > 0" do
      customer = customers(:one)
      mcoc = customer.movies_checked_out_count

      post check_out_path(params: rental_data)

      customer = Customer.find_by(id: customer.id)
      customer.movies_checked_out_count.must_equal mcoc + 1
    end

    it "returns bad_request with bad params" do
      rental_data[:customer_id] = nil

      proc {
        post check_out_path(params: rental_data)
      }.must_change 'Rental.count', 0

      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include 'ok'
      body['ok'].must_equal false
    end

    it "does not decrease available inventory if available inventory is 0" do
      movie_one = movies(:one)
      ai = movie_one.available_inventory

      post check_out_path(params:
        {
          customer_id: customers(:one).id,
          movie_id: movies(:one).id
        })

      movie_one = Movie.find_by(id: movie_one.id)
      movie_one.available_inventory.must_equal ai
    end

    it "does not increase customer's movies checked out count if available inventory is 0" do
      customer_one = customers(:one)
      mcoc = customer_one.movies_checked_out_count

      post check_out_path(params:
        {
          customer_id: customers(:one).id,
          movie_id: movies(:one).id
        })

      customer_one = Customer.find_by(id: customer_one.id)
      customer_one.movies_checked_out_count.must_equal mcoc
    end
  end

  describe "check_in" do
    let(:rental_data) {
      {
        customer_id: customers(:one).id,
        movie_id: movies(:one).id
      }
    }

    it "changes the status of the rental to returned and returns customer_id and movie_id in request body if given valid params" do
      post check_in_path(params: rental_data)

      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include 'customer_id'
      body['customer_id'].must_equal customers(:one).id
      body.must_include 'movie_id'
      body['movie_id'].must_equal movies(:one).id
      body.must_include 'status'
      body['status'].must_equal 'returned'
    end

    it "increases the movie's available inventory if given valid params" do
      movie_one = movies(:one)
      ai = movie_one.available_inventory

      post check_in_path(params: rental_data)

      movie_one = Movie.find_by(id: movie_one.id)
      movie_one.available_inventory.must_equal ai + 1
    end

    it "decrease the customer's movies checked out count if given valid params" do
      customer = customers(:one)
      mcoc = customer.movies_checked_out_count

      post check_in_path(params: rental_data)

      customer = Customer.find_by(id: customer.id)
      customer.movies_checked_out_count.must_equal mcoc - 1
    end

    it "returns bad_request with bad params" do
      rental_data[:customer_id] = nil

      post check_in_path(params: rental_data)

      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include 'ok'
      body['ok'].must_equal false
    end
  end
end
