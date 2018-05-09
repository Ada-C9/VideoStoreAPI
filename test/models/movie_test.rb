require "test_helper"

describe Movie do
  describe "valid movies" do
    it "must be valid movie" do
      movie = movies(:one)
      movie.valid?.must_equal true
    end
  end

  describe "invalid movies" do
    it "title must be valid" do
      movie = movies(:one)
      movie.title = nil

      movie.valid?.must_equal false
    end

    it "inventory must be valid" do
      movie = movies(:one)
      movie.inventory = nil

      movie.valid?.must_equal false
    end

    it "inventory cannot be a string" do
      movie = movies(:one)
      movie.inventory = "cat"

      movie.valid?.must_equal false
    end

    it "cannot have string for available_inventory" do
      movie = movies(:one)
      movie.available_inventory = "cat"
      movie.valid?.must_equal false
    end

    it "must have available_inventory between 0 and total inventory" do
      movie = movies(:one)
      movie.available_inventory = -1

      movie.valid?.must_equal false
    end

    it "must have available_inventory between 0 and total inventory" do
      movie = movies(:one)
      movie.available_inventory = 6

      movie.valid?.must_equal false
    end
  end

  describe "Movie.decrement method" do
    it "decrements available_inventory of a movie when given valid data" do
      movie = movies(:two)
      available = movie.available_inventory

      Movie.decrement(movie)

      movie.available_inventory.must_equal (available -1)
    end
  end

end
