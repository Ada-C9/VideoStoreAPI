require "test_helper"

describe MoviesController do
  describe 'index' do
    it "responds with success" do
      get movies_path
      must_respond_with :success
    end

    it "returns " do
      get movies_path
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an array " do
      get movies_path

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      must_respond_with :success
    end
     it "returns all of the movies" do
       get movies_path

       body = JSON.parse(response.body)
       body.length.must_equal Movie.count
       must_respond_with :success
     end

  end

  describe 'show' do
    it 'returns a single movie' do
      keys = %w(overview release_date title)
      movie = movies(:one)

      get movie_path(movie.id)

      response.header['Content-Type'].must_include 'json'
      body = JSON.parse(response.body) #rails provides this
      body.must_be_kind_of Hash
      body.keys.sort.must_equal keys
      body["id"].must_equal movie.id
    end

    it 'provides an error message if movie not found' do

    end
  end
end
