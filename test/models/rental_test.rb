require "test_helper"

describe Rental do

  let(:rental) { rentals(:one) }
  describe "intialization" do
    it "must be valid" do
      value(rental).must_be :valid?
    end

    it "must not be valid without a movie" do
      value(rental).must_be :valid?
      rental.movie = nil
      value(rental).wont_be :valid?
      rental.errors.messages.must_include :movie
    end

    it "must not be valid without a customer" do
      value(rental).must_be :valid?
      rental.customer = nil
      value(rental).wont_be :valid?
      rental.errors.messages.must_include :customer
    end
  end

  describe "relations" do
    it "responds to movies" do
      rental.must_respond_to :movie
    end

    it "responds to customers" do
      rental.must_respond_to :customer
    end
  end


end
