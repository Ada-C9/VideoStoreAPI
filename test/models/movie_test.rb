require "test_helper"

describe Movie do
  let(:movie) { Movie.new }
  let(:movie1) {movies(:one) }

  describe "relations" do
    it "has a list of rentals" do
      movie.rentals.each do |rental|
        rental.must_be_instance_of Rental
        rental.movie.must_be_instance_of Movie
        rental.movie.must_equal movie1
      end
    end
  end

  describe "validations" do
    it "has validation for empty parameters" do
      movie.valid?.must_equal false
    end

    it "has validation for title presence" do
      movie1.title = nil
      movie1.valid?.must_equal false
      movie1.errors.messages.must_include :title

      movie1.title = ""
      movie1.valid?.must_equal false
      movie1.errors.messages.must_include :title
    end

    it "has validation for release date presence" do
      movie1.release_date = nil
      movie1.valid?.must_equal false
      movie1.errors.messages.must_include :release_date

      movie1.release_date = ""
      movie1.valid?.must_equal false
      movie1.errors.messages.must_include :release_date
    end

    it "has validation for inventory presence" do
      movie1.inventory = nil
      movie1.valid?.must_equal false
      movie1.errors.messages.must_include :inventory

      movie1.inventory = ""
      movie1.valid?.must_equal false
      movie1.errors.messages.must_include :inventory
    end


    it "must be valid" do
      movie1.valid?.must_equal true
    end
  end

  describe "methods" do
    it "computes available_inventory" do
      movie1.available_inventory.must_equal 10
    end
  end

end
