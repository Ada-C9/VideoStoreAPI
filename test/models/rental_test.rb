require "test_helper"

describe Rental do

  describe 'validations' do
    it 'must have a valid date range' do
      movie = Movie.first
      customer = Customer.first

      rental = Rental.new(movie_id: movie.id, customer_id: customer.id, start_date: Date.today, end_date: Date.today - 1)
      rental.must_be_instance_of Rental
      rental.wont_be :valid?
    end
  end # validations

  describe "relationships" do
    before do
      @movie =  Movie.first
      @customer = Customer.first
      @rental = Rental.new(customer_id: @customer.id, movie_id: @movie.id, start_date: Date.today, end_date: Date.today + 1)

    end

    it "belongs to a customer" do

      @rental.customer
      @rental.customer.name.must_equal @customer.name
    end

    it "belongs to a movie" do

      @rental.movie
      @rental.movie.title.must_equal @movie.title

    end
  end
end 
