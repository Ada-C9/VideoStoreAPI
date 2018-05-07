require "test_helper"

describe "Movie" do
  describe "valid movies" do
    it "must be valid if given valid movie info" do
      movie = (movies(:one))
      value(movie).must_be :valid?
    end
  end

  describe "invalid movies" do
    it "must return error if missing title" do
      movie = movies(:one)
      movie.title = nil
      value(movie).valid?.must_equal false
    end

    it "must return error if missing inventory" do
      movie = movies(:one)
      movie.inventory = nil
      value(movie).valid?.must_equal false
    end

    it "must return error if inventory is not an integer" do
      movie = movies(:one)
      movie.inventory = "not a number"
      value(movie).valid?.must_equal false
    end
  end
end
