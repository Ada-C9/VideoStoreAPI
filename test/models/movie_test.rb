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

    it "must have a unique name" do
      movie = Movie.first

      other_movie = Movie.new(title: movie.title, inventory: 4)

      other_movie.wont_be :valid?
    end

  end
end
