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
      second_cust = Customer.create!(title: "next title")
      @movie.customers << second_cust

      @movie.customers.each do |customer|
        customer.must_be_kind_of Customer
      end
    end
  end

  describe 'validations' do
    it "must be valid" do
      value(movie).must_be :valid?
    end
  end
end
