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

  it "must be valid" do



  end
end
