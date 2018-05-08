require "test_helper"

describe MoviesController do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end


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
