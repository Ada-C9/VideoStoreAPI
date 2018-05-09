require "test_helper"
require 'date'

describe "Movie" do
  describe "valid movies" do
    it "must be valid if given valid movie info" do

      movie_data = {
        title: "Not another movie" ,
        overview: "more of the same" ,
        release_date: 1993 ,
        inventory: 12
      }

      movie = Movie.create(movie_data)

      value(movie).must_be :valid?
    end
  end

  describe "invalid movies" do
    it "must return error if missing title" do

      movie_data = {
        title: nil ,
        overview: "more of the same" ,
        release_date: 1993 ,
        inventory: 12
      }

      movie = Movie.new(movie_data)

      movie.save

      movie.valid?.must_equal false
    end

    it "must return error if missing inventory" do

      movie_data = {
        title: "not another movie" ,
        overview: "more of the same" ,
        release_date: 1993 ,
        inventory: nil
      }

      movie = Movie.new(movie_data)

      movie.save

      movie.valid?.must_equal false
    end

    it "must return error if inventory is not an integer" do

      movie_data = {
        title: "friday night and lights are low" ,
        overview: "dancing queen" ,
        release_date: 1993 ,
        inventory: "abba"
      }

      movie = Movie.new(movie_data)

      movie.save

      movie.valid?.must_equal false
    end
  end

  describe "Movie.decrement method" do
    it "decrements available_inventory of a movie when given valid data" do
      movie_data =  {
          title: "Not another movie" ,
          overview: "more of the same" ,
          release_date: 1993 ,
          inventory: 12,
          available_inventory: 10
        }

      movie = Movie.create(movie_data)

      available = movie.available_inventory

      Movie.decrement(movie)

      movie.available_inventory.must_equal (available -1)
    end
  end
end
