require "test_helper"

describe Customer do
  describe 'relations' do
    it 'has a list of rentals' do
      customer = customers(:kari)
      customer.must_respond_to :rentals

      customer.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end
    end
    it 'has a list of movies' do
      customer = customers(:kari)
      customer.must_respond_to :movies

      customer.rentals.each do |rental|
        rental.must_respond_to Movie
      end
    end
  end

  describe 'validations' do
    it "must be valid" do
      customer = customers(:kari)
      customer.must_be :valid?
    end
    it "requires a name" do
      customer = Customer.new
      customer.valid?.must_equal false
      customer.errors.messages.must_include :name
    end
  end
end
