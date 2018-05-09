require "test_helper"

describe Movie do
  let(:movie) { Movie.new }
  let(:babe) { movies(:babe) }
  let(:keanu) { movies(:keanu) }
  let(:rental) { Rental.new }
  # let(:rental_one) { rentals(:rental_one) }
  # let(:rental_two) { rentals(:rental_two) }

  describe 'valid' do
    it "must be valid" do
      babe.valid?.must_equal true
    end

    it "is invalid with nil title" do
      babe.title = nil
      babe.valid?.must_equal false
      babe.errors.messages.must_include :title
    end

    it "is invalid with a nil inventory" do
      keanu.inventory = nil
      keanu.valid?.must_equal false
      keanu.errors.messages.must_include :inventory
    end

    it "is invalid with an inventory that is not an integer" do
      babe.inventory = "string"
      babe.valid?.must_equal false
      babe.errors.messages.must_include :inventory
    end
  end

  describe 'relations' do
    it "responds to rentals" do
      babe.must_respond_to :rentals
      babe.rentals.count.must_equal 1
      babe.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end
    end
  end

  describe "inventory" do
    it "returns the available inventory" do
      babe.available_inventory.must_equal 2
    end
  end

  end
