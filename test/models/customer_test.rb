require "test_helper"

describe Customer do
  describe "validations" do
    before do
      @customer = Customer.new(
        name: "coco",
        address: "114 Pine St.",
        city: "Seattle",
        state: "Washington",
        postal_code: "98100",
        phone: "(206) 206 2066"
      )
    end

    it "can be created with sufficient data" do
      result = @customer.valid?
      result.must_equal true
    end

    it "can not be created without a name" do
      @customer.name = ""
      result = @customer.valid?
      result.must_equal false
    end

    it "can not be created without a phone number" do
      @customer.phone = ""
      result = @customer.valid?
      result.must_equal false
    end

    it "can not be created if with same name and same phone as existed customer" do
      customer1 = Customer.new(
        name: "coco",
        address: "1232314 Pine St.",
        city: "Portland",
        state: "Oregon",
        postal_code: "98100",
        phone: "(206) 206 2066"
      )

      @customer.save
      result = customer1.valid?
      result.must_equal false
      customer1.errors.messages.must_include :phone
    end
  end

  describe 'relations' do
    it 'relates rental and rental_id' do
      customer = customers(:one)

      customer.rentals.must_include rentals(:one)
    end
  end
end
