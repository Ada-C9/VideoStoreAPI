require "test_helper"

describe Rental do
  describe 'validations' do
    before do
      @movie = Movie.first
      @customer = Customer.first
    end

    it 'must have a valid date range' do
      rental = Rental.new(movie_id: @movie.id, customer_id: @customer.id, start_date: Date.today, end_date: Date.today - 1)
      rental.must_be_instance_of Rental
      rental.wont_be :valid?
    end
  end # validations
end
