require "test_helper"

describe MoviesController do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end
  describe "index" do
    it "is a real working route" do
      get movies_url

      must_respond_with :success
      response.header['Content-Type'].must_include 'json'
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all of the movies" do
      get movies_url

      body = JSON.parse(response.body)
      body.length.must_equal Customer.count
    end

    it "returns movies with exactly the required fields" do

    end
  end

  describe "create" do
    let(:movie_data) {
      {
        title: "Best Movie",
        overview: "Stuff happens",
        release_date: "2000-01-01",
        inventory: 10
      }
    }

    it "creates a new movie" do
      before_movie_count = Movie.count
      post movies_url, params: { movie: movie_data }
      must_respond_with :success

      Movie.count.must_equal before_movie_count + 1

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "id"

      Movie.find(body["id"]).title.must_equal movie_data[:title]
    end
  end

  describe "show" do
    # This bit is up to you!
    it "can get a movie" do
      keys = %w(available_inventory id inventory overview release_date title)
      movie = movies(:two)
      get movie_path(movie.id)
      must_respond_with :success

      response.header['Content-Type'].must_include 'json'
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.keys.sort.must_equal keys
      body["id"].must_equal movie.id
    end

    it "yields a not found status and also return some error text if the movie D.N.E" do
      movie_id = Movie.last.id + 1
      get movie_path(movie_id)
      must_respond_with :not_found
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "id"
    end
  end
end
