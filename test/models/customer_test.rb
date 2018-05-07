require "test_helper"

describe Customer do

  it "will be valid with a name" do
    customer = Customer.first
    customer.name.nil?.must_equal false
    customer.valid?.must_equal true
  end

  it "will be invalid without a name" do
    customer = Customer.first
    customer.name = nil
    customer.save
    customer.valid?.must_equal false
  end


end
