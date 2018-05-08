require "test_helper"

describe MoviesController do
  describe 'index' do
    it "it is a real route" do
      get movies_path

      must_respond_with :success
    end

    it "returns json" do
      get movies_path

      response.header['Content-type'].must_include 'json'
    end

    it "returns all the movies" do
      get movies_path

      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end

    it "returns the movies with all required fields" do
      keys = %w(id inventory overview  release_date title)

      get movies_path

      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys
      end
    end
  end
end
