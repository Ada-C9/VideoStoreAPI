require "test_helper"

describe MoviesController do
  describe "index" do
    it "is a real working route" do
      get movies_path
      must_respond_with :success
    end

    it "returns json" do
      get movies_path
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an Array" do
      get movies_path
      body = JSON.parse(response.body)
      body.must_be_instance_of Array
    end

    it "returns all of the movies" do
      get movies_path
      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end

    it "returns movies with exactly the fields required" do
      keys = %w(id title release_date overview inventory )
      get movies_path
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys.sort
      end
    end
  end

  describe "create" do
    let(:movie_data) {
      {
        title: "Code Girl",
        release_date: "2000-1-10",
        overview: "Stellar",
        inventory: 11,
        available_inventory: 11
      }
    }

    it "Creates a new movie" do
      proc {
        post movies_path, params: movie_data
      }.must_change 'Movie.count', 1

      must_respond_with :success
    end

    it "Won't create a movie without title" do
      movie_data.delete(:title)

      proc {
        post movies_path, params: movie_data
      }.must_change 'Movie.count', 0

      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "title"
    end

    it "Won't create a movie without release date" do
      movie_data.delete(:release_date)

      proc {
        post movies_path, params: movie_data
      }.must_change 'Movie.count', 0

      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "release_date"
    end

    it "Won't create a movie without inventory" do
      movie_data.delete(:inventory)

      proc {
        post movies_path, params: movie_data
      }.must_change 'Movie.count', 0

      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "inventory"
    end
  end

  describe "show" do
    # This bit is up to you!
    it "can get a movie" do
      get movie_path(Movie.first.id)
      must_respond_with :success
    end

    it "returns a 404 for movies that are not found" do
      #Arrange
      movie = movies(:bride)
      movie.destroy
      get movie_path(movie.id)
      #Assert
      must_respond_with :not_found
    end
  end

end
