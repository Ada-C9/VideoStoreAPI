require "test_helper"

describe Movie do
  let(:movie) { Movie.new(title: "title", inventory: 4) }

  describe "Validations" do
    it "must be valid" do
      movie.must_be :valid?
    end

    it "must have a title" do
      movie.title = nil

      movie.valid?.must_equal false
      movie.errors.must_include :title
    end

    it "must have an existing inventory" do
      movie.inventory = nil

      movie.valid?.must_equal false
      movie.errors.must_include :inventory
    end

    it "must raise error for negative inventory" do
      movie.inventory = -1

      movie.valid?.must_equal false
      movie.errors.must_include :inventory
    end

    it "must raise error for non-integer inventory" do
      movie.inventory = "two"

      movie.valid?.must_equal false
      movie.errors.must_include :inventory
    end
  end

  describe "Relationships" do
    it "can have a list of rentals" do
      rentals(:one).movie_id = movies(:one).id
      rentals(:one).customer_id = customers(:one).id
      rentals(:one).save

      movies(:one).must_respond_to :rentals
      movies(:one).rentals[0].must_be_kind_of Rental
    end
  end
  
end
