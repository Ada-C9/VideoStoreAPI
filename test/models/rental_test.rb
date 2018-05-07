require "test_helper"

describe Rental do
  let(:rental) { Rental.new }
  let(:rental_one) { rentals(:rental_one) }
  let(:rental_two) { rentals(:rental_two) }

  describe "validations" do

    it "must be valid" do
      rental_one.valid?.must_equal true
    end

    it "requires a checkout_date" do
      rental_two.checkout_date = nil
      rental_two.valid?.must_equal false
    end

  end

  describe "relations" do
    it "must have a customer" do
      rental_one.must_respond_to :customer
      rental_one.customer.must_be_kind_of Customer
      rental_one.customer.name.must_equal "Nora"
      rental_two.must_respond_to :customer
      rental_two.customer.must_be_kind_of Customer
      rental_two.customer.name.must_equal "Sara"
    end

    it "must have a movie" do
      rental_one.must_respond_to :movie
      rental_one.movie.must_be_kind_of Movie
      rental_one.movie.title.must_equal "Babe"
      rental_two.must_respond_to :movie
      rental_two.movie.must_be_kind_of Movie
      rental_two.movie.title.must_equal "Keanu"
    end
  end
end
