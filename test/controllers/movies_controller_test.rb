require "test_helper"

describe MoviesController do
  describe "index" do
    it "is a real working route" do
      get movies_path
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

    it "returns no movies if there are no movies, status :not_found" do
      Movie.destroy_all

      get movies_url
      must_respond_with :ok
      body = JSON.parse(response.body)
      body.length.must_equal Movie.count

    end

    it "returns movies with exactly the required fields" do

      keys = %w(title release_date id)

      get movies_url
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys.sort
      end
    end
  end

  describe "show" do
    it "can get a movie" do
      get movie_path(movies(:two).id)
      must_respond_with :success
    end

    it "returns movies with exactly the required fields" do

      keys = %w(title overview release_date inventory available_inventory)
      get movie_path(movies(:two).id)

      body = JSON.parse(response.body)
      body.keys.sort.must_equal keys.sort
    end

    it "responds with not_found if get a movie given invalid id" do
      movie = movies(:two)
      movie.destroy
      get movie_path(movie.id)
      must_respond_with :not_found
    end
  end

  describe "create" do
    let(:movie_data) {
      {
        title: "Pirates of the Caribbean",
        overview: "The ocean's black pearl saves and perishes",
        release_date: "2000",
        inventory: 3,
        available_inventory: 3
      }
    }

    it "Creates a new movie" do
      proc{
        post movies_path, params: movie_data
      }.must_change "Movie.count", 1
      must_respond_with :success

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body["id"].must_equal Movie.last.id

    end

    it "returns a bad request for a bad params data" do
      movie_data[:title] = nil

      proc{
        post movies_url, params: movie_data
      }.must_change "Movie.count", 0
      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "title"
    end

  end
end
