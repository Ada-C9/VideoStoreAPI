require "test_helper"

describe Customer do
  let(:customer) { Customer.new }
  let(:nora) { customers(:nora) }
  let(:sara) { customers(:sara) }

  describe "validations" do
    it "must be valid" do
      nora.valid?.must_equal true
    end

    it "requires a name" do
      sara.name = nil
      sara.valid?.must_equal false
    end

    it "requires a registered_at date" do
      bob = Customer.new(name: "Bob", registered_at: "today")
      bob.valid?.must_equal false
    end
  end

  describe "relations" do
    it "has a list of rentals" do
      nora.must_respond_to :rentals
      nora.rentals.count.must_equal 1
      nora.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end
      nora.rentals.first.movie.title.must_equal "Babe"
    end
  end

  describe "movies_checked_out_count" do
    it "returns the number of movies a customer has checked out" do
      sara.movies_checked_out_count.must_equal 1
    end
  end

end
