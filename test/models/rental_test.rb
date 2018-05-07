require "test_helper"

describe Rental do
  let(:rental) { Rental.new(checkout_date: Date.new, customer_id: customers(:one).id, movie_id: movies(:one).id) }

  describe "Validations" do
    it "must be valid" do
      rental.must_be :valid?
    end

    it "it have must have a checkout date" do
      rental.checkout_date = nil

      rental.valid?.must_equal false
      rental.errors.must_include :checkout_date
    end
  end

  describe "Relationships" do
    it "must belong to a customer" do
      rental.must_respond_to :customer
    end

    it "must belong to a movie" do
      rental.must_respond_to :movie
    end
  end
  
end
