require "test_helper"

describe Movie do
  let(:movie) { Movie.new(title: "Dogtoth", overview: "Weird and good", release_date: "1979-01-18", inventory: 1)}

  it "must be valid" do
    value(movies(:bride)).must_be :valid?
  end

  it "must not create without title" do
    proc { Movie.new(release_date: "2015-12-2", inventory: 2) }.must_change 'Movie.count', 0
  end

  it "must not create with invalid title data" do
    proc { Movie.new(title: "123", release_date: "2015-12-2", inventory: 2) }.must_change 'Movie.count', 0
  end

  it "must not create without release date" do
    proc { Movie.new(title: "Party", inventory: 2) }.must_change 'Movie.count', 0
  end
end
