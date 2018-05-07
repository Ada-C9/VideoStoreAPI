require "test_helper"

describe Movie do
  let(:movie) { Movie.new }
  let(:movie1) {movies(:one) }


  it "must be valid" do
    value(movie).must_be :valid?
  end
end
