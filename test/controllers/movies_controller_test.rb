require "test_helper"

describe MoviesController do

  describe 'index' do

    it "successfully returns json containing a collection of all movies " do
      get movies_url
      must_respond_with :success
      response.header['Content-Type'].must_include 'json'
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      body.length.must_equal Movie.count
    end

    it "returns movies with the required fields" do
      get movies_url
      keys = %w(id release_date title)
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys
      end
    end

    it "returns an empty array if there are no movies" do
      Movie.destroy_all
      get movies_url
      body = JSON.parse(response.body)
      body.must_equal []
    end

  end

end
