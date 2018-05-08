require "test_helper"
require 'pry'

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
      keys = %w(inventory overview release_date title )
      movie = movies(:one)

      get movie_path(movie.id)

      response.header['Content-Type'].must_include 'json'
      body = JSON.parse(response.body) #rails provides this
      body.must_be_kind_of Hash
      body.keys.sort.must_equal keys

      body["title"].must_equal movie.title
    end

    it 'provides an error message if movie not found' do
      # Arrange
      movie_id = Movie.first.id + 1
      # Act
      get movie_path(movie_id)

      # Assert
      response.header['Content-Type'].must_include 'json'
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body["errors"].must_include "id"
      must_respond_with :not_found
    end
  end

  describe 'create' do
    # lazy load function that executes only if using the movie variable
    let(:movie_data) {
      {
        title: "A Movie",
        overview: "It's definitely a movie.",
        release_date: Date.parse("1982-1-1"),
        inventory: 10
      }
    }

    it "creates a new movie" do
      assert_difference "Movie.count", 1 do
        post movies_url, params: { movie: movie_data}
        assert_response :success
      end

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "id"

      Movie.find(body["id"]).title.must_equal "A Movie"
    end


    it "responds with bad_request for invalid data" do
      bad_data = movie_data.clone()
      bad_data.delete(:title)
      assert_no_difference "Movie.count" do
        post movies_url, params: { movie: bad_data}
        assert_response :bad_request
      end

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"

      Movie.find_by(overview: "It's definitely a movie.").must_equal nil
    end
  end
end
