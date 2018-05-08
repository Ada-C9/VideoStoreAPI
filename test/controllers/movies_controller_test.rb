require "test_helper"

describe MoviesController do
    describe "index" do
      it "returns an array of json" do
        get movies_url
        must_respond_with :success
        response.header['Content-Type'].must_include 'json'
        body = JSON.parse(response.body)
        body.must_be_kind_of Array
      end

      it "returns movies with a name that matches the search" do
        get movies_url, params: {search: "Bob Esponja"}
        body = JSON.parse(response.body)
        body.each do |movie|
          movie["name"].must_equal "Bob Esponja"
        end
      end

      it "returns movies with exactly the required fields" do
        keys = %w(available_inventory id inventory overview release_date title)
        get movies_url, params: {search: "Bob Esponja"}
        body = JSON.parse(response.body)
        body.each do |movie|
          movie.keys.sort.must_equal keys
        end
      end

    end # index

    describe "show" do
      it "can get a movie" do
        keys = %w(available_inventory id inventory overview release_date title )
        movie = Movie.first
        get movie_path(movie.id)
        must_respond_with :success

        response.header['Content-Type'].must_include 'json'
        body = JSON.parse(response.body)
        body.must_be_kind_of Hash
        body.keys.sort.must_equal keys
        body['id'].must_equal movie.id
      end

      it "it should return not found and returns some error test when movie does not exist" do

        movie_id = Movie.last.id + 1
        get movie_path(movie_id)
        must_respond_with :not_found
        body = JSON.parse(response.body)
        body.must_be_kind_of Hash
        body.must_include "errors"
        body["errors"].must_include "id"

      end

    end # show
end
