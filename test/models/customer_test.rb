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

end
