require "test_helper"

describe MoviesController do

  describe "index" do
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
      keys = %w(available_inventory id release_date title)
      get movies_url
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys
      end
    end
  end

  describe "show" do
    it "can get a movie" do
      get movie_path(movies(:babe).id)
      must_respond_with :success
    end

    it "returns a movie with exactly the required fields" do
      keanu = movies(:keanu)
      keys = %w(available_inventory id inventory overview release_date title)
      get movie_url(keanu.id)
      body = JSON.parse(response.body)
      body.keys.sort.must_equal keys
    end

    it "returns a 404 for movies that are not found" do
      movie = movies(:babe)
      movie.destroy
      get movie_path(movie.id)
      must_respond_with :not_found
    end
  end

  describe "create" do
    let(:movie_data) {
      {
        title: "Free Willy",
        release_date: Date.today,
        overview: "Whale movie",
        inventory: 3
      }
    }

    let(:bad_movie_data) {
      {
        release_date: Date.today,
        inventory: 3
      }
    }

    it "creates a new movie" do
      proc {
        post movies_path, params: movie_data
      }.must_change 'Movie.count', 1
      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "id"

    # Check that the ID matches
      Movie.find(body["id"]).title.must_equal movie_data[:title]
    end

    it "returns a bad request for a bad params data" do
      proc {
        post movies_path, params: bad_movie_data
      }.must_change "Movie.count", 0
      must_respond_with :bad_request

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "title"
    end

  end

end
