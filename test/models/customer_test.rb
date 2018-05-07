require "test_helper"

describe Customer do
  it "must be valid" do
    value(customers(:one)).must_be :valid?
  end

  it "must have a name" do
    customer = customers(:one)
    customer.name = nil

    customer.valid?.must_be false
  end
end
