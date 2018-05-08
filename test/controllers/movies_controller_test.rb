require "test_helper"

describe MoviesController do
  describe 'index' do
    it 'can get list of movies' do
      keys = %w(id title release_date)

      get movies_path

      must_respond_with :success
      response.header['Content-Type'].must_include 'json'

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      body.length.must_equal Movie.count
    end

    it 'returns movies with exactly the required fields' do
      keys = %w(id title release_date).sort
      get movies_path
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys
      end
    end
  end

  describe 'show' do
    it 'can get one movie' do
      movie = movies(:beautiful)
      keys = %w(id title release_date).sort

      get movie_path(movie.id)
      must_respond_with :success

      response.header['Content-Type'].must_include 'json'

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.keys.sort.must_equal keys
      body["id"].must_equal movie.id
    end
  end
end
