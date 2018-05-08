require "test_helper"

describe Customer do
  let(:customer) { customers(:one) }

  it "must be valid" do
    value(customer).must_be :valid?
  end

  it "must have name" do
    customer.name = nil
    customer.valid?.must_equal false
  end

  it "must have address" do
    customer.address = nil
    customer.valid?.must_equal false
  end

  it "must have city" do
    customer.city = nil
    customer.valid?.must_equal false
  end

  it "must have state" do
    customer.state = nil
    customer.valid?.must_equal false
  end

  it "must have postal_code" do
    customer.postal_code = nil
    customer.valid?.must_equal false
  end

  it "must have phone" do
    customer.phone = nil
    customer.valid?.must_equal false
  end

  it "must have postal code length of 5" do
    customer.postal_code = '1234'
    customer.valid?.must_equal false

    customer.postal_code = '1238498520348'
    customer.valid?.must_equal false
  end

  it "must have phone length = 10" do
    customer.postal_code = '1234'
    customer.valid?.must_equal false

    customer.postal_code = '12384985203829387948'
    customer.valid?.must_equal false
  end

  describe 'relationships' do
    it "has many rentals" do
      customer.rentals.must_equal [rentals(:one)]

      customer.rentals.count.must_equal 1
    end

    it "can have 0 rentals" do
      customer.rentals.each do |rental|
        rental.destroy
      end

      customer.rentals.count.must_equal 0
    end
  end
end
