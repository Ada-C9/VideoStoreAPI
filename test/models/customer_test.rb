require "test_helper"

describe Customer do
  describe "validations" do
    it "must be valid" do
      value(customers(:one)).must_be :valid?
    end

    it "must have a name" do
      customer = customers(:one)
      customer.name = nil

      customer.valid?.must_equal false
    end

    it "must have a phone num" do
      customer = customers(:two)
      customer.phone = nil

      customer.valid?.must_equal false
    end
  end

  describe "relations" do
    it "must return an array" do
      customer = customers(:one)
      customer.rentals.count.must_equal 2
    end

    it "must return empty array if no rentals" do
      customer = customers(:two)
      customer.rentals.must_equal []
    end

    it "must respond when new rental created" do
      #TODO
    end
  end

  describe "add_movie" do
    it "increments movie count" do
      customer = customers(:one)
      customer.movies_checked_out_count.must_equal 0

      Customer.add_movie(customer)
      customer.movies_checked_out_count.must_equal 1
    end
  end

  describe "remove_movie" do
    it "decrements movie count" do
      customer = customers(:one)
      customer.movies_checked_out_count.must_equal 0

      Customer.add_movie(customer)
      customer.movies_checked_out_count.must_equal 1

      Customer.remove_movie(customer)
      customer.movies_checked_out_count.must_equal 0
    end
  end

end
