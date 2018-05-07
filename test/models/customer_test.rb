require "test_helper"
require 'pry'

describe Customer do
  let(:customer) { Customer.new(name: "name") }

  describe "Validations" do
    it "must be valid" do
      customer.must_be :valid?
    end

    it "raises error if name missing" do
      customer.name = nil

      customer.valid?.must_equal false
      customer.errors.must_include :name
    end
  end

  describe "Relationships" do
    it "can have a list of rentals" do
      rentals(:one).customer_id = customers(:one).id
      rentals(:one).movie_id = movies(:one).id
      rentals(:one).save

      person.must_respond_to :rentals
      person.rentals[0].must_be_kind_of Rental
    end
  end
  
end
