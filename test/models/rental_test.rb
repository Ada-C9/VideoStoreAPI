require "test_helper"

describe Rental do

  it "must be valid" do
    # rental = rentals(:one)
    movie = Movie.first
    customer = Customer.first
    rental = Rental.new(movie_id: movie.id, customer_id: customer.id)

    value(rental).must_be :valid?
  end

  it "will be invalid without customer_id" do
    movie = Movie.first
    rental = Rental.new(movie_id: movie.id)

    result = rental.valid?

    result.must_equal false
  end

  it "will be invalid without movie_id" do
    customer = Customer.first
    rental = Rental.new(customer_id: customer.id)

    result = rental.valid?

    result.must_equal false
  end
end
