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
      @customer = customers(:one)
    end

    it 'has many rentals' do

      @customer.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end
    end


    it 'has many movies' do

      @customer.movies.each do |movie|
        movie.must_be_kind_of Movie
      end

    end

    it 'returns an empty array of movies if no rentals placed' do

      test_customer = Customer.new(name: "Napoleon Dynomite")

      test_customer.save

      test_customer.rentals.must_equal []
      test_customer.movies.must_equal []
    end

  end

end
