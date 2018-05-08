require "test_helper"

describe Movie do
  describe 'validations' do

    before do
      @movie = Movie.new(title: 'test movie', inventory: 1, available_inventory: 1)
    end

    it "is valid when all required fields are present" do
      result = @movie.valid?
      result.must_equal true
    end

    it "is invalid without a title" do
      @movie.title = nil
      result = @movie.valid?
      result.must_equal false
      @movie.errors.messages.must_include :title
    end

    it "is invalid if the inventory is less than 1 " do
      @movie.inventory = 0
      result = @movie.valid?
      result.must_equal false
      @movie.errors.messages.must_include :inventory
    end

    it "is invalid if the available inventory is not a number" do
      @movie.available_inventory = nil
      result = @movie.valid?
      result.must_equal false
      @movie.errors.messages.must_include :available_inventory
    end

  end

  describe 'relations' do

    before do
      @movie = movies(:one)
    end

    it "has many rentals" do
      @movie.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end
    end

    it "has a list of customers who rented it" do
      @movie.customers.each do |customer|
        customer.must_be_kind_of Customer
      end
    end

    it "returns an empty array if the movie has not been rented" do
      new_movie = Movie.create!(title: 'test', inventory: 2, available_inventory: 2)
      new_movie.rentals.must_equal []
      new_movie.customers.must_equal []
    end

  end

end
