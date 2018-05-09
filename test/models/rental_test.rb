require "test_helper"

describe Rental do
  let(:rental) { Rental.new }
  let(:one) { rentals(:one) }

  it "has a movie" do
    rental = Rental.new(due_date: "10-02-2018")
    movie = Movie.first
    customer = Customer.first

    rental.movie = movie
    rental.customer = customer

    rental.movie_id.must_equal movie.id
    rental.customer_id.must_equal customer.id

  end
end
