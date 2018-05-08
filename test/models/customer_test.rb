require "test_helper"

describe Customer do
  before do
    @customer_data = {
      name: 'tester',
      phone: '(000) 000-0000'
    }
    @customer = Customer.new(@customer_data)
  end

  it "is valid with a name and phone number length of 14" do

     @customer.must_be :valid?
  end

  it "is invalid with no name" do
    @customer.name = nil

    @customer.wont_be :valid?
    @customer.errors.messages.must_include :name
  end

  it "is invalid with no phone number" do
    @customer.phone = nil

    @customer.wont_be :valid?
    @customer.errors.messages.must_include :phone
  end

  it "is invalid with a phone number less than 14 char" do
    @customer.phone = '3'
    @customer.wont_be :valid?
    @customer.errors.messages.must_include :phone
  end



end
