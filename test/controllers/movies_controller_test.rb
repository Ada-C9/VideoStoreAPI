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

    it 'returns movie with exactly the required fields' do
      movie = Movie.first
      keys = %w(id title release_date).sort
      get movie_path(movie)
      body = JSON.parse(response.body)

      body.keys.sort.must_equal keys
    end

    it "yields a not_found status if the movie DNE and returns an error" do
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
