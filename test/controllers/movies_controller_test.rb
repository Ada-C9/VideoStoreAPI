require "test_helper"

describe MoviesController do
  describe "index" do
    # These tests are a little verbose - yours do not need to be
    # this explicit.
    it "is a real working route" do
      get movies_url
      must_respond_with :success
    end

    it "returns json" do
      get movies_url
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an Array" do
      get movies_url

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all of the movies" do
      get movies_url

      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end

    it "returns pets with exactly the required fields" do
      keys = %w(id release_date title)
      get movies_url
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys
      end
    end
  end

  describe "show" do


    it "can get a movie" do
      get movie_path(movies(:two).id)
      must_respond_with :success
    end

    it "returns a 404 for movies that are not found" do
      #Arrange
      movie = movies(:two)
      movie.destroy
      #Action
      get movie_path(movie.id)
      #Assert
      must_respond_with :not_found
    end
  end

  describe "create" do
    let(:movie_data) {
      {

        title: "Planet",
        overview: "fiction",
        release_date: Date.new(2018-05-07),
        inventory: 5

      }
    }

    it "Creates a new movie" do
      proc{
        post movies_path, params: movie_data
      }.must_change 'Movie.count',1
      must_respond_with :success

    end

    it "returns bad request for params data" do
      movie_data[:title] = nil
      proc{
        post movies_path, params: {movie: movie_data}
      }.must_change 'Movie.count',0
      must_respond_with :bad_request

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "ok"
      body["ok"].must_equal false
      body.must_include "errors"
      body["errors"].must_include "title"
      #Movie.find(body["id"]).title.must_equal movie_data[:title]
      # end
    end

  end
end
