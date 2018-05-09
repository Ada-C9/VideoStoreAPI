require "test_helper"
require 'pry'

describe Rental do
  before do
    customer = Customer.first
    movie = Movie.first
    date = Date.today

    @rental_data = {
      checkout: date,
      due_date: date + 7,
      customer_id: customer.id,
      movie_id: movie.id
    }
  end

  describe 'validations' do

    it 'can be created with all valid information' do
      rental = Rental.new(@rental_data)
      # binding.pry
      rental.checkout.must_be_kind_of Date
      rental.due_date.must_be_kind_of Date
      rental.must_be :valid?, rental.errors.messages
    end

    it 'cannot be created without customer_id' do
      rental = Rental.new(@rental_data)
      rental.customer_id = nil

      rental.wont_be :valid?
      rental.errors.messages.must_include :customer_id
    end

    it 'cannot be created without movie_id' do
      rental = Rental.new(@rental_data)
      rental.movie_id = nil

      rental.wont_be :valid?
      rental.errors.messages.must_include :movie_id
    end

    it 'cannot be created without check_out date' do
      rental = Rental.new(@rental_data)
      rental.checkout = nil

      rental.wont_be :valid?
      rental.errors.messages.must_include :checkout
    end

    it 'cannot be created without due_date' do
      rental = Rental.new(@rental_data)
      rental.due_date = nil

      rental.wont_be :valid?
      rental.errors.messages.must_include :due_date
    end

    it 'cannot be created with a checkout date not in the date format' do
      rental = Rental.new(@rental_data)
      rental.checkout = ""

      rental.checkout.wont_be_kind_of Date
      rental.wont_be :valid?
      rental.errors.messages.must_include :checkout
    end
  end

  describe 'relations' do
    it "associates the correct customer and movie with customer_id and movie_id" do
      customer = Customer.first
      movie = Movie.first

      rental = Rental.new(@rental_data)
      rental.customer = customer
      rental.movie = movie

      rental.customer_id.must_equal customer.id
      rental.movie_id.must_equal movie.id
    end

    it "is invalid if movie DNE" do
      # binding.pry
      @rental_data[:customer_id] = Customer.last.id + 1
      @rental_data[:movie_id] = Movie.last.id + 1

      rental = Rental.new(@rental_data)


      rental.wont_be :valid?
      rental.errors.messages.must_include :movie
      rental.errors.messages.must_include :customer
    end

  end
end
