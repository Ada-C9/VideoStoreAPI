require "test_helper"
require 'date'

describe Customer do
  before do
    @customer = customers(:Linda)
    @customer_2 = customers(:Bob)

    @lion_king = movies(:Lion)
    @phantom = movies(:Phantom)

    @rental_phantom = Rental.create(customer_id:@customer_2.id,movie_id:@phantom.id, check_in:Date.new, check_out:Date.new+15, due_date: Date.new+7)
    @rental_lion = Rental.create(customer_id:@customer_2.id,movie_id:@lion_king.id, check_in:Date.new, check_out:Date.new+15, due_date: Date.new+7)
  end

  describe "validations" do
    it 'requires a name' do
      @customer[:name].wont_be_nil
      @customer.valid?.must_equal true
    end

    it 'will not be valid with all nil values' do
      @customer[:name] = nil
      @customer.valid?.must_equal false
      @customer.errors.size.must_equal 1
      @customer.errors.details.keys[0].must_equal :name
      @customer.errors.messages[:name][0].must_equal "can't be blank"
    end

    it 'will not be valid with an empty string' do
      @customer[:name] = ''
      @customer.valid?.must_equal false
      @customer.errors.size.must_equal 1
      @customer.errors.details.keys[0].must_equal :name
      @customer.errors.messages[:name][0].must_equal "can't be blank"
    end
  end

  describe "relations" do
    it 'has many rentals' do
      @customer_2.rentals.count.must_equal 2
      @customer_2.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end
      @customer_2.rentals[0].movie_id.must_equal @phantom.id
      @customer_2.rentals[1].movie_id.must_equal @lion_king.id
    end
  end

  describe 'moveis_check_out_count' do
    it 'must be able to raise movie count for a customer' do
      proc {
        @customer_2.add_to_check_out_count
      }.must_change '@customer_2.movies_checked_out_count',1
    end
  end
end
