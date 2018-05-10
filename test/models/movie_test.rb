require "test_helper"

describe Movie do
  describe 'relations' do
    before do
      # @customer = Customer.create!(name: "test customer")
      @customer = Customer.first
      puts @customer.name
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

  describe 'describe available inventory methods' do

    # the next test uses the yml 'gijane' which has different inventory compared to available_inventory
    it 'sets the available_inventory of a movie equal to the inventory' do
      movie = movies(:gijane)

      movie.set_avail_inventory

      movie.available_inventory.must_equal 3
    end

    # the next two tests uses the yml 'purple' which has available_inventory set to nil as a default
    it 'decreases available inventory of a movie by 1' do
      movie = movies(:purple)
      movie.set_avail_inventory
      before_count = movie.available_inventory

      movie.dec_avail_inventory

      after_count = movie.available_inventory

      after_count.must_equal before_count - 1

    end

    it 'increases available inventory of a movie by 1' do
      movie = movies(:purple)
      movie.set_avail_inventory
      before_count = movie.available_inventory

      movie.inc_avail_inventory

      after_count = movie.available_inventory

      after_count.must_equal before_count + 1

    end
  end
end
