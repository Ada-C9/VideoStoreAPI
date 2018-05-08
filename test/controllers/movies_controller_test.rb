require "test_helper"

describe MoviesController do

  describe 'index' do

    before do
      get movies_url
    end

    it "gets the movies route" do
      must_respond_with :success
    end

    it "returns json" do
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an Array" do
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns a list of all movies" do
      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end

    it "returns movies with the required fields" do
      keys = %w(id title release_date)
      body = JSON.parse(response.body)
      body.each do |movie
        movie.keys.sort.must_equal keys
      end
    end

  end

end
