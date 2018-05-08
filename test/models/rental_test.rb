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

    end

    it 'will raise an error with a missing check_out' do
    end
  end

  describe "relations" do
    it 'belongs to a customer' do
    end

    it 'belongs to a movie' do
    end
  end

end
# describe Rental do
#   let(:rental) { Rental.new }
#
#   it "must be valid" do
#     value(rental).must_be :valid?
#   end
# end
