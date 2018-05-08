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

  describe 'relations' do

    before do
      @customer = customer(:one)
    end

    it 'connects rental and rentals_id' do

      rental = rentals(:two)

      @customer.rentals.must_include rental

    end

    it 'connects movie and movies_id' do

      movie = movies(:two)

      @customer.movie.must_be movie      

    end

  end

end
