require "test_helper"

describe MoviesController do
  describe 'index' do
    it "should get index" do
      # Action
      get movies_url

      # Assert
      value(response).must_be :success?
    end

    it "returns json" do
      # Action
      get movies_url

      # Assert
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an Array" do
      # Action
      get movies_url

      # Assert
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all of the movies" do
      # Action
      get movies_url

      # Assert
      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end

    it "returns movies with exactly the required fields" do
      # Arrange
      keys = %w(available_inventory id inventory overview release_date title)

      # Action
      get movies_url

      # Arrange
      body = JSON.parse(response.body)

      body.each do |movie|
        # Assert
        movie.keys.sort.must_equal keys
      end
    end
  end

  describe 'Create' do
    let(:movie_data) {
      {
        title: "The Creation",
        release_date: "1979-01-18",
        overview: "A very interesting overview",
        inventory: 20,
        available_inventory: 10
      }
    }

    it "Can create a new movie" do
      # Action / Assert
      proc {
        post movies_path, params: movie_data
      }.must_change 'Movie.count', 1


      # Assert
      assert_response :success
    end

    it 'Returns bad request for bad params data' do
      # Arrange
      movie_data.delete(:title)

      # Assert
      proc {
        post movies_path, params: {movie: movie_data}
      }.wont_change 'Movie.count'

      # Arrange
      body = JSON.parse(response.body)

      # Assert
      must_respond_with :bad_request
      body.must_be_kind_of Hash
      body.must_include "ok"
      body["ok"].must_equal false
      body.must_include "errors"
      body["errors"].must_include "title"
    end
  end

  describe 'Show' do
      it "can get a movie" do
        # Action
        get movie_path(movies(:blacksmith).id)

        # Assert
        must_respond_with :success
      end

      it "returns a 404 for movies that are not found" do
        # Arrange
        movie = movies(:blacksmith)
        Rental.destroy_all
        movie.destroy

        # Action
        get movie_path(movie.id)

        # Assert
        must_respond_with :not_found
      end
    end

end
