require "test_helper"
require 'pry'

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

    it 'will be invalid witout a valid movie_id' do
      @rental.movie_id = Movie.last.id + 1
      @rental.wont_be :valid?
    end

    it 'belongs to a customer' do

      customer = Customer.first
      @rental.customer = customer
      @rental.customer_id.must_equal customer.id
    end

    it 'will be invalid witout a valid customer_id' do
      @rental.customer_id = Customer.last.id + 1
      @rental.wont_be :valid?
    end

  end

  describe 'find_rental_movie' do
    before do
      customer_id = customers(:two).id
      movie_id = movies(:two).id
      @rental_params = {movie_id: movie_id, customer_id: customer_id}
    end
    it "returns an instance of a Movie given a valid movie id" do
      binding.pry
      result = find_rental_movie(@rental_params)

      result.must_be_kind_of Movie
      result.id.must_equal @rental_params[:movie_id]

    end

    it "returns nil if given invalid movie id" do
      @rental_params[:movie_id] = Movie.last.id + 1

      result = find_rental_movie(@rental_params)

      result.id.must_be nil
    end

  end
end
