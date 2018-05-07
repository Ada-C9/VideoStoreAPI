require "test_helper"

describe MoviesController do
  describe "index" do
    it "is a working route that sends json" do
      get movies_url
      must_respond_with :success

      response.header["Content-Type"].must_include "json"
    end

    it "returns an array of all movies" do
      get movies_url
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      body.length.must_equal Movie.count
    end

    it "returns movies with exactly the required fields" do
      keys = %W[id inventory overview release_date title]
      get movies_url

      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys
      end

    end
  end

  describe "show" do
    it "can get a movie" do
      keys = %W[id inventory overview release_date title]

      movie_id = movies(:one).id
      get movie_url(movie_id)
      must_respond_with :success

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.keys.sort.must_equal keys
      body["id"].must_equal movie_id
    end

    it "sends a not found status and returns error text if the movie DNE" do
      movie_id = Movie.last.id + 1
      get movie_url(movie_id)
      must_respond_with :not_found
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "id"
    end

  end

  describe "create" do
    let(:movie_data) {
      {
        title: "coco",
        overview: "great",
        release_date: Date.today,
        inventory: 100
      }
    }

    before do
      @before_count = Movie.count
    end

    it "can create a new movie" do
      post movies_url, params: {
        movie: movie_data
      }
      must_respond_with :success

      Movie.count.must_equal @before_count + 1
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      Movie.find(body["id"]).title.must_equal movie_data[:title]
    end

    it "returns an error for invalid movie data" do
      movie_data[:title] = ""

      post movies_url, params: {
        movie: movie_data
      }
      must_respond_with :bad_request
      Movie.count.must_equal @before_count
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "title"
    end
  end
end
