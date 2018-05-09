require "test_helper"

describe Rental do
  let(:rental) { Rental.new }
  let(:rental_one) { rentals(:rental_one) }
  let(:rental_two) { rentals(:rental_two) }

  describe "validations" do

    it "must be valid" do
      rental_one.valid?.must_equal true
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

  describe "get due date" do
    it "must get the due date" do
      rental_one.get_due_date.must_equal Date.parse('2018-05-14')
    end
  end
end
