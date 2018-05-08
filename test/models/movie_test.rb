require "test_helper"

describe Movie do
  describe "validations" do
    it "Must have a title" do
      movie = Movie.new(overview: "Great movie", release_date: Date.today, inventory: 4)

      movie.must_be_kind_of Movie
      movie.wont_be :valid?
    end

    it "is valid with a title and inventory" do
      movie = Movie.new(title: "El laberinto del Fauno", inventory: 5)

      movie.must_be_kind_of Movie
      movie.must_be :valid?

    end

    it "Must have an inventory" do
      movie = Movie.new(overview: "Great movie", release_date: Date.today, title: "El laberinto del Fauno")

      movie.must_be_kind_of Movie
      movie.wont_be :valid?

    end

  end

  describe "relationships" do
    it "has many rentals" do
      movie = Movie.first

      movie.rentals
    end
  end
end
