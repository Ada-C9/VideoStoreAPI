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
      get movie_path("fake_id")
      must_respond_with :not_found
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "ok"
      body["ok"].must_equal false
      body.must_include "errors"
    end
  end

  describe "create" do
    let(:movie_data) {
      {
        title: "Gremlins",
        overview: "Don't get them wet",
        release_date: "2018-5-7",
        inventory: 25
      }
    }

    it "Creates a new movie" do
      proc {
        post movies_path, params: movie_data
      }.must_change 'Movie.count', 1

      must_respond_with :success


    end

    it "returns with bad request with invalid data" do
      movie_data[:title] = nil

      proc {
        post movies_path, params: movie_data
      }.must_change 'Movie.count', 0

      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "title"

    end

  end
end
