require "test_helper"
require 'pry'

describe Movie do
  describe "relations" do
    it "movies has list of rentals" do
      movie = movies(:one)
      movie.must_respond_to :rentals
    end
  end

  describe "validations" do
    let(:movie_nil) { Movie.new() }

    it "can create a movie with both title and release_date" do
      movie.title = "Lion King"
      movie.release_date = "1992-01-02"
      is_valid = movie.valid?
      is_valid.must_equal true
    end

    it "must have both title and release_date" do
      movie.valid?.must_equal false
      movie.errors.messages.must_include :title
      movie.errors.messages.must_include :release_date
    end

    it "must have title" do
      movie.release_date = "1992-01-02"
      movie.valid?.must_equal false
      movie.errors.messages.must_include :title
    end

    it "must have release_date" do
      movie.title = "test_title"
      movie.valid?.must_equal false
      movie.errors.messages.must_include :release_date
    end
  end
end
