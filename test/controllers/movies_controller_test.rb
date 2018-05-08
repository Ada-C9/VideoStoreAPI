require "test_helper"

describe MoviesController do
  describe "Index" do
    it "is a real working route" do
      get movies_path

      must_respond_with :success
    end

    it "returns json" do
      get movies_path

      response.header['Content-Type'].must_include 'json'
    end

    it "returns an array" do
      get movies_path

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all movies" do
      get movies_path

      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end

    it "returns movies with all fields" do
      keys = %w(inventory overview release_date title)
      get movies_path

      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys
      end
    end
  end

  describe "Show" do
    it "gets a movie" do
      get movie_path(movies(:one).id)

      must_respond_with :success
    end

    it "returns json" do
      get movie_path(movies(:one).id)

      response.header['Content-Type'].must_include 'json'
    end

    it "returns a movie hash" do
      get movie_path(movies(:one).id)

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
    end

    it "returns a 404 for movie not found" do
      movie = movies(:one)
      movie.destroy
      get movie_path(movie.id)

      must_respond_with :not_found
    end

    describe "Create" do
      let(:movie_data) {
        {
          title: "Pirates of the Caribbean",
          release_date: "2003",
          inventory: 5,
          overview: "Captain Jack Sparrow does some things with the Black Pearl"
        }
      }

      it "Creates a new movie" do

        proc {
          post movies_path, params: {movie: movie_data}
        }.must_change 'Movie.count', 1

        must_respond_with :success
      end

      it "will not create a new movie with bad data" do
        not_a_movie = {
          release_date: "2003",
          inventory: 5,
          overview: "Captain Jack Sparrow does some things with the Black Pearl"
        }

        proc {
          post movies_path, params: {movie: not_a_movie}
        }.wont_change 'Movie.count'

        must_respond_with :bad_request
        body = JSON.parse(response.body)
        body.must_be_kind_of Hash
        body.must_include "ok"
        body["ok"].must_equal false
        body.must_include "errors"
        body["errors"].must_include "title"
      end


    end




  end
end
