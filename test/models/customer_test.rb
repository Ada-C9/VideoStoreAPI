require "test_helper"

describe Customer do

  describe "validations" do
    it "must have a name" do
      customer = Customer.new(address: "123 Main St.", city: "Seattle", state: "Washington", postal_code: "12345", phone: "777-777-7777", registered_at: DateTime.now)
      customer.must_be_instance_of Customer
      customer.wont_be :valid?
    end

    it "is valid with a name" do
      customer = Customer.new(name: "Sebastián Piñera")
      customer.must_be_instance_of Customer
      customer.must_be :valid?
    end

  end

end
