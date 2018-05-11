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
      get movies_url, params: {title: "Laberinto del Fauno"}
      body = JSON.parse(response.body)
      body.each do |movie|
        movie["title"].must_equal "Laberinto del Fauno"
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
  describe "create" do
    let(:movie_data) {
      {
        title: "Isle of Dogs",
        overview: "great movie",
        inventory: 3,
        release_date: Date.today
      }
    }

    it "should create a new valid movie" do
      old_movie_count = Movie.count
      post movies_url, params: movie_data
      Movie.count.must_equal old_movie_count + 1
      newest_movie = Movie.last
      newest_movie.title.must_equal movie_data[:title]
    end

    it "should yield an error and error text when invalid title for movie" do
      movie_data[:title] = nil
      old_movie_count = Movie.count
      post movies_url, params: { movie: movie_data }
      Movie.count.must_equal old_movie_count
      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "title"
    end

    it "should yield an error and error text when invalid inventory for movie" do
      movie_data[:inventory] = nil
      old_movie_count = Movie.count
      post movies_url, params: { movie: movie_data }
      Movie.count.must_equal old_movie_count
      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "inventory"
    end
  end

end
