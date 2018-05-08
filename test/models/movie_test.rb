require "test_helper"

describe Movie do
  describe "relations" do
    it "has a collection of rentals" do
      movie = movies(:HP)
      movie.must_respond_to :rentals
      movie.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end
    end
  end

  describe "validations" do
    before do
      @movie = Movie.new(
        title: "Wonder Woman",
        overview: "I don't feel like writing this",
        release_date: Date.parse("05/07/18"),
        inventory: 3
      )
    end

    it "must be valid with all required fields" do
      count_before = Movie.count
      @movie.valid?.must_equal true

      @movie.save

      Movie.last.title.must_equal @movie.title
      Movie.count.must_equal count_before + 1
    end

    it "is invalid without a title and does not update DB" do
      count_before = Movie.count
      @movie.title = nil
      @movie.valid?.must_equal false

      @movie.save

      @movie.errors.messages.must_include :title
      Movie.count.must_equal count_before
    end

    it "is invalid without an overview and does not update DB" do
      count_before = Movie.count
      @movie.overview = nil
      @movie.valid?.must_equal false

      @movie.save

      @movie.errors.messages.must_include :overview
      Movie.count.must_equal count_before
    end

    it "is invalid without a release date and does not update DB" do
      count_before = Movie.count
      @movie.release_date = nil
      @movie.valid?.must_equal false

      @movie.save

      @movie.errors.messages.must_include :release_date
      Movie.count.must_equal count_before
    end

    it "is invalid without an inventory and does not update DB" do
      count_before = Movie.count
      @movie.inventory = nil
      @movie.valid?.must_equal false

      @movie.save

      @movie.errors.messages.must_include :inventory
      Movie.count.must_equal count_before
    end

    it "is invalid if inventory is less than 0 and does not update DB" do
      count_before = Movie.count
      @movie.inventory = -2
      @movie.valid?.must_equal false

      @movie.save

      @movie.errors.messages.must_include :inventory
      Movie.count.must_equal count_before
    end
  end
end
