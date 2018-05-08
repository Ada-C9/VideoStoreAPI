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

  describe 'show' do
    it 'can get a movie' do
      keys = %w(id inventory overview  release_date title)

      movie = movies(:movie_1)

      get movie_path(movie.id)

      must_respond_with :success
      response.header['Content-Type'].must_include 'json'
      body = JSON.parse(response.body)
      body.keys.sort.must_equal keys
      body['id'].must_equal movie.id
    end

    it 'returns not found if the movie DNE' do
      movie_id = Movie.last.id + 1
      get movie_path(movie_id)
      must_respond_with :not_found

      body = JSON.parse(response.body)
      body.must_include 'errors'
      body['errors'].must_include 'id'
    end
  end
end
