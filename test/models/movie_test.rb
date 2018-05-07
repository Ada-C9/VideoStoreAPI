require "test_helper"

describe Movie do
  let(:movie) { movies(:one) }

  it "must be valid" do
    value(movie).must_be :valid?
  end

  it "must have title" do
    movie.title = nil
    movie.valid?.must_equal false
  end

  it "must have overview" do
    movie.overview = nil
    movie.valid?.must_equal false
  end

  it "must have release_date" do
    movie.release_date = nil
    movie.valid?.must_equal false
  end

  it "must have title" do
    movie.title = nil
    movie.valid?.must_equal false
  end

  it "must have non-negative inventory" do
    movie.inventory = -1
    movie.valid?.must_equal false

    movie.inventory = "jdfaaldsjb"
    movie.valid?.must_equal false
  end
end
