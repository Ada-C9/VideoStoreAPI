require "test_helper"

describe Rental do
  describe 'relations' do

    before do
      @rental = Rental.new
    end

    it 'belongs to a movie' do

      movie = Movie.first
      @rental.movie = movie
      @rental.movie_id.must_equal movie.id

    end

    it 'belongs to a customer' do

      customer = Customer.first
      @rental.customer = customer
      @rental.customer_id.must_equal customer.id

    end

  end
end
