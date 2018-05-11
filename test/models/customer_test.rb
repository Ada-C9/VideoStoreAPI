require "test_helper"

describe Customer do
  let(:customer) { customers(:tommy) }
  let(:dee) { customers(:dee) }

  it "must be valid with all attributes included" do
    value(customer).must_be :valid?
  end

  it "must be invalid without a name" do
    customer.name = nil
    value(customer).wont_be :valid?
    customer.errors.messages.must_include :name
  end

  it "must be invalid without a registered_at date" do
    customer.registered_at = nil
    value(customer).wont_be :valid?
    customer.errors.messages.must_include :registered_at
  end

  it "must be invalid without an address" do
    customer.address = nil
    value(customer).wont_be :valid?
    customer.errors.messages.must_include :address
  end

  it "must be invalid without a city" do
    customer.city = nil
    value(customer).wont_be :valid?
    customer.errors.messages.must_include :city
  end

  it "must be invalid without a state" do
    customer.state = nil
    value(customer).wont_be :valid?
    customer.errors.messages.must_include :state
  end

  it "must be invalid without a postal_code" do
    customer.postal_code = nil
    value(customer).wont_be :valid?
    customer.errors.messages.must_include :postal_code
  end

  it "must be invalid without a phone" do
    customer.phone = nil
    value(customer).wont_be :valid?
    customer.errors.messages.must_include :phone
  end

  describe 'relations' do
    it "must respond to rentals" do
      customer.must_respond_to :rentals
    end
  end

  describe 'get_count method' do
    it "returns the number of movies checked_out by a specific customer" do
      movies_checked_out_count = customer.get_count
      movies_checked_out_count.must_equal 1
    end

    it "return zero if the customer does not have any movies checked out" do
      movies_checked_out_count = dee.get_count
      movies_checked_out_count.must_equal 0
    end
  end

end
