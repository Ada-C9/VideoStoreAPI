require "test_helper"

describe Customer do

  describe 'validations' do
    before do
            @old_customer_count = Customer.count
    end
    it 'will not create  have a name' do
      customer = Customer.new(name: "Honey BooBoo")

      customer.must_be :valid?

      customer.save

      Customer.count.must_equal @old_customer_count + 1
    end

    it 'is invaild without a name' do
      customer = Customer.new(name: nil)

      customer.wont_be :valid?

      customer.save

      Customer.count.must_equal @old_customer_count
    end
  end

end
