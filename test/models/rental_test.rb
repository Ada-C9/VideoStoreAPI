require "test_helper"

describe Rental do
  let(:rental) { rentals(:one) }


  it "must be valid" do
    # rental = rentals(:one)
    movie = Movie.first
    customer = Customer.first
    rental = Rental.new(movie_id: movie.id, customer_id: customer.id)

    value(rental).must_be :valid?
  end
end
