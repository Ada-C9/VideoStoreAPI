require "test_helper"

describe Rental do

  movie = Movie.first
  customer = Customer.first
  let(:rental) { Rental.new(movie_id: movie.id, customer_id: customer.id) }

  it "must be valid" do
    value(rental).must_be :valid?
  end

  describe "relationship" do
    it "belongs to movie" do
      rental.must_respond_to :movie
    end

    it "belongs to customer" do
      rental.must_respond_to :customer
    end
  end
end
