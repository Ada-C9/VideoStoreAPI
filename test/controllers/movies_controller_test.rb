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

    it "returns movies with exactly the required fields" do
      keys = %w( id release_date title)

      get movies_url
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys
      end
    end
  end

  describe "show" do

    it "can get a movie" do
      get movie_path(movies(:one).id)
      must_respond_with :success
    end

    it "returns 404 for movies that are not found" do
      movie = movies(:two)
      movie.destroy
      get movie_path(movie.id)
      must_respond_with :not_found
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "ok" 
      body["ok"].must_equal false
      body.must_include "errors"

    end
  end


end
