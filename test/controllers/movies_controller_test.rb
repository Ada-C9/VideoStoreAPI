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
      keys = %w(id release_date title)
      get movies_url
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys
      end
    end

    it "returns empty array if there are no movies" do
      all_movies = Movie.all
      all_movies.each do |movie|
        movie.destroy
      end
      get movies_url
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      body.must_equal []
    end
  end

  describe "show" do
    it "is a working route that recieves one movie" do
      get movie_path( movies(:harry).id )
      must_respond_with :success
    end

    it "returns one movie with required data" do
      keys = %w(available_inventory inventory overview release_date title)
      get movie_path( movies(:harry).id )
      body = JSON.parse(response.body)
      body.keys.sort.must_equal keys
    end

    it "returns a 404 code for movies that do not exist" do
      movie = movies(:harry)
      movie.destroy
      get movie_path(movie.id)
      must_respond_with :bad_request
    end
  end

  describe "create" do
    let (:new_movie) {
      {
        title: "New movie",
        overview: "Popular new movie",
        release_date: "1979-01-18",
        inventory: 4
      }
    }

    it "creates a new movie" do
      proc {
        post movies_url, params: new_movie
      }.must_change 'Movie.count', 1
      must_respond_with :success

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "id"
    end

    it "returns a bad_request without all required params" do
      keys = %w(inventory overview release_date title)
      keys.each do |key|
        new_movie[key] = nil
        proc {
          post movies_url, params: new_movie
        }.must_change 'Movie.count', 0
        must_respond_with :bad_request
        body = JSON.parse(response.body)
        body.must_be_kind_of Hash
        body.must_include "errors"
        body["errors"].must_include "inventory"
      end
    end
  end

end
