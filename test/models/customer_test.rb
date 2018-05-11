require "test_helper"

describe Customer do
  let(:customer) { Customer.new(name: "Captain Planet", registered_at: "Wed, 29 Apr 2015 07:54:14 -0700", address: "123 Green St", city: "Tree Town", state: "HI", postal_code: "12345", phone: "(919) 434-3203", movies_checked_out_count: 0) }

  it "must be valid" do
    value(customer).must_be :valid?
  end

  it "must not save if there is no name" do
    proc { Customer.new(address: "1234 Candy Cane Lane") }.must_change 'Customer.count', 0
  end

  it "must not save if name data is invalid" do
    proc { Customer.new(name: "1234") }.must_change 'Customer.count', 0
  end

  describe "update_count" do
    it "increases the count when movie is checked out" do
      count = customer.movies_checked_out_count

      customer.update_count("out")
      customer.movies_checked_out_count.must_equal count + 1
    end

    it "decreases the count when movie is checked in" do
      count = customer.movies_checked_out_count

      customer.update_count("in")
      customer.movies_checked_out_count.must_equal count - 1

    end


  end
end
