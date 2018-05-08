require "test_helper"

describe Movie do
  describe 'relations' do
    before do
      @customer = Customer.create!(name: "test customer")
      @movie = Movie.new(title: "test movie")
      @movie.customers << @customer
    end

    it 'can connect customer to customer_id' do
      @movie.customers.last.id.must_equal @customer.id
    end

    it 'has a list of customers' do
      @movie.must_respond_to :customers
      second_cust = Customer.create!(name: "fake name")
      @movie.customers << second_cust

      @movie.customers.each do |customer|
        customer.must_be_kind_of Customer
      end
    end
  end

  describe 'validations' do

    it "can be created with all valid fields" do
      movie = Movie.new(title: "test movie")

      result = movie.valid?

      result.must_equal true
    end

    it 'is invalid without a title' do
      movie = Movie.new

      result = movie.valid?

      result.must_equal false
    end
  end
end
