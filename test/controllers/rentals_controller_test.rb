require "test_helper"

describe RentalsController do
  describe "Index" do
    it "is a real working route" do
      get rentals_path

      must_respond_with :success
    end

    it "returns json" do
      get rentals_path

      response.header['Content-Type'].must_include 'json'
    end

    it "returns an array" do
      get rentals_path

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all rentals" do
      get rentals_path

      body = JSON.parse(response.body)
      body.length.must_equal Rental.count
    end

    it "returns rentals with all fields" do
      keys = %w(checkin_date checkout_date customer_id movie_id)
      get rentals_path

      body = JSON.parse(response.body)
      body.each do |rental|
        rental.keys.sort.must_equal keys
      end
    end
  end

  describe "Show" do
    it "gets a rental" do
      get rental_path(rentals(:one).id)

      must_respond_with :success
    end

    it "returns json" do
      get rental_path(rentals(:one).id)

      response.header['Content-Type'].must_include 'json'
    end

    it "returns a rental hash" do
      get rental_path(rentals(:one).id)

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
    end

    it "returns a 404 for rental not found" do
      rental = rentals(:one)
      rental.destroy
      get rental_path(rental.id)

      must_respond_with :not_found
    end
  end
end
