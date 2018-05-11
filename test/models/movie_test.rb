require "test_helper"

describe Movie do
  let(:movie) { Movie.first }

  it "must be valid" do
    value(movie).must_be :valid?
  end

  it "must have a name" do
    movie = Movie.first

    movie.title = nil

    movie.wont_be :valid?
  end

  it "must respond to customer" do
    movie = Movie.first
    movie.must_respond_to :rentals

  end
end
