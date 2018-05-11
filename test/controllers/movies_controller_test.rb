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
      inventory: 5,
      available_inventory: 10
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



  describe 'show' do

    it 'can get a movie' do

      keys = %w(available_inventory id inventory overview release_date title)

      movie = movies(:two)

      # Act
      get movie_path(movie.id)

      # Assert
      must_respond_with :success

      response.header['Content-Type'].must_include 'json'
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.keys.sort.must_equal keys
      body["id"].must_equal movie.id
    end

    it 'yields a not_found status and also return some error if the movie DNE' do
      movie_id = Movie.last.id + 1

      get movie_path(movie_id)

      must_respond_with :not_found

      # Check that it sent us some error text
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "id"
    end

  end

end
