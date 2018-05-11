require "test_helper"
require 'pry'

describe Movie do
  describe 'validations' do

    before do
      @movie = movies(:one)
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

    it "is invalid if the inventory is not a number " do
      @movie.inventory = "dfkjgh"
      result = @movie.valid?
      result.must_equal false
      @movie.errors.messages.must_include :inventory
    end

    it "is valid even if the available inventory is not a number" do
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

  describe 'decrement_available_inventory' do

    before do
      @movie = movies(:one)
    end

    it "reduces available inventory for specific movie by 1" do
      before_avail_inv = @movie.available_inventory

      @movie.decrement_available_inventory

      @movie.available_inventory.must_equal before_avail_inv - 1

    end

    it "will not reduce available inventory if count is 0" do
      @movie.available_inventory = 0

      @movie.decrement_available_inventory

      @movie.available_inventory.must_equal 0

    end

  end

  describe 'increment_available_inventory' do

    before do
      @movie = movies(:one)
    end

    it "increases available inventory for specific movie by 1" do
      @movie.available_inventory = @movie.inventory - 1
      @movie.save

      before_avail_inv = @movie.available_inventory

      @movie.increment_available_inventory

      @movie.available_inventory.must_equal before_avail_inv + 1

    end

    it "will not increase available inventory more than total inventory" do
      @movie.available_inventory = @movie.inventory

      before_available_inventory = @movie.available_inventory

      @movie.increment_available_inventory

      @movie.available_inventory.must_equal before_available_inventory

    end

  end


end
