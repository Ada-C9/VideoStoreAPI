require "test_helper"
require 'pry'

describe Rental do
  before do
    @customer = customers(:Linda)
    @customer_2 = customers(:Bob)

    @lion_king = movies(:Lion)
    @phantom = movies(:Phantom)

    @rental_phantom = Rental.create(customer_id:@customer_2.id,movie_id:@phantom.id, check_in:Date.new, check_out:Date.new+15, due_date: Date.new+7)
    @rental_lion = Rental.create(customer_id:@customer_2.id,movie_id:@lion_king.id, check_in:Date.new, check_out:Date.new+15, due_date: Date.new+7)
  end

  describe "validations" do
    it 'will raise an error with a missing customer_id' do
      @rental_phantom.customer_id = nil
      @rental_phantom.customer_id.must_be_nil
      @rental_phantom.valid?.must_equal false
      @rental_phantom.errors.size.must_equal 2
      @rental_phantom.errors.details.keys[0].must_equal :customer
      @rental_phantom.errors.details.keys[1].must_equal :customer_id
      @rental_phantom.errors.messages.values[0][0].must_equal "must exist"
      @rental_phantom.errors.messages.values[1][0].must_equal "can't be blank"
    end

    it 'will raise an error with a missing movie_id' do
      @rental_phantom.movie_id = nil
      @rental_phantom.movie_id.must_be_nil
      @rental_phantom.valid?.must_equal false
      @rental_phantom.errors.size.must_equal 2
      @rental_phantom.errors.details.keys[0].must_equal :movie
      @rental_phantom.errors.details.keys[1].must_equal :movie_id
      @rental_phantom.errors.messages.values[0][0].must_equal "must exist"
      @rental_phantom.errors.messages.values[1][0].must_equal "can't be blank"
    end

    it 'will raise an error with a missing check_in' do
      @rental_lion.check_in = nil
      @rental_lion.check_in.must_be_nil
      @rental_lion.valid?.must_equal false
      @rental_lion.errors.size.must_equal 1
      @rental_lion.errors.messages.keys[0].must_equal :check_in
      @rental_lion.errors.messages.values[0][0].must_equal "can't be blank"
    end

    it 'will raise an error with a missing check_out' do
      @rental_lion.check_out = nil
      @rental_lion.check_out.must_be_nil
      @rental_lion.valid?.must_equal false
      @rental_lion.errors.size.must_equal 1
      @rental_lion.errors.messages.keys[0].must_equal :check_out
      @rental_lion.errors.messages.values[0][0].must_equal "can't be blank"
    end

    # it 'a valid rental contains expected content' do
    #   @rental_lion.customer_id
    #   @
    # end
  end

  describe "relations" do
    it 'belongs to a customer' do
      @rental_phantom.customer.must_be_kind_of Customer
      @rental_phantom.customer.id.must_equal @customer_2.id
    end

    it 'belongs to a movie' do
      @rental_phantom.movie.must_be_kind_of Movie
      @rental_phantom.movie.id.must_equal @phantom.id
    end
  end

end
