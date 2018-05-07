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
end
