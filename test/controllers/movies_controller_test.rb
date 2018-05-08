require "test_helper"

describe MoviesController do
  describe "index" do
    it "must provide a list of movies" do
      get movies_url

      must_respond_with :success
    end

    it "returns all the movies" do
      get movies_url

      body = JSON.parse(response.body)
      body.length.must_equal Movie.count

    end

    it "returns json" do
      get movies_url
      response.header['Content-Type'].must_include 'json'
    end

  end

  describe "create" do
    movie_data = {
        title: "Hook",
        overview: "Robin Williams duh",
        release_date: 1997,
        inventory: 5
      }

    it "Creates a new movie" do
        # this is taking the count before and after
        before_count = Movie.count

          post movies_url, params: movie_data
          must_respond_with :success

          Movie.count.must_equal before_count + 1


        body = JSON.parse(response.body)
        body.must_be_kind_of Hash
        body.must_include "id"

        # Check that the ID matches
        Movie.find(body["id"]).title.must_equal movie_data[:title]
      end

  end

end
