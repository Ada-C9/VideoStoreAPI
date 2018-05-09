require "test_helper"

describe Customer do
  let(:customer) { Customer.new }
  let(:customer) { customers(:mary)}

  describe "relations" do
    it "has a list of rentals" do
      mary = customers(:mary)
      customer.rentals.each do |rental|
        rental.must_be_kind_of Rental
        rental.customer.must_be_instance_of Customer
        rental.customer.must_equal mary
      end
    end
  end

  describe "validations" do

    it "must be valid" do
      customer.valid?.must_equal true
    end

    it "must have validation for name" do
      customer.name = nil
      customer.valid?.must_equal false
      customer.errors.messages.must_include :name
    end

    it "must have validation for registered date" do
      customer.registered_at = nil
      customer.valid?.must_equal false
      customer.errors.messages.must_include :registered_at
    end
    it "must have validation for phone" do
      customer.phone = nil
      customer.valid?.must_equal false
      customer.errors.messages.must_include :phone
    end

  end
  describe "method" do
    it "returns the count of movies checked" do
      customer.movies_checked_out_count.must_equal 2
    end
  end
end
