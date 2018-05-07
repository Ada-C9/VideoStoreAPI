require "test_helper"

describe Customer do
  let(:customer) { Customer.new }

  it "must be valid" do
    value(customer).must_be :valid?
  end

  it "must have a name" do
    customer = Customer.first

    customer.name = nil
    customer.reload

  a = customer.valid?

 a.must_equal false
  end
end
