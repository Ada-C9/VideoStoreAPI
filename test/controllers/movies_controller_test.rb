require "test_helper"

describe MoviesController do
  describe "index" do
    it "gets all the movies" do
      # Arrange
      keys = %w(id release_date title)

      # Act
      get movies_url

      # Assert
      must_respond_with :success

      response.header['Content-Type'].must_include 'json'
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      body.length.must_equal Movie.count
      body.each do |movie|
        movie.keys.sort.must_equal keys
      end
    end
  end

  describe "show" do
    it "can get a movie" do
      # Arrange
      keys = %w(id inventory overview release_date title)
      movie = movies(:LOTR)

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

    it "yields a not_found status and also return some error text if the movie D.N.E." do
      movie_id = Movie.last.id + 1

      get movie_path(movie_id)

      must_respond_with :not_found

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "id"
    end
  end

  describe "create" do
    let(:movie_data) {
      {
        title: "Wonder Woman",
        overview: "About the most badass superhero in the world",
        release_date: Date.parse("02/05/18"),
        inventory: 4
      }
    }

    it "Creates a new movie" do
      assert_difference "Movie.count", 1 do
        post movies_url, params: { movie: movie_data }
        must_respond_with :success
      end

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "id"

      # Check that the ID matches
      Movie.find(body["id"]).title.must_equal movie_data[:title]
    end

    it "Returns an error for an invalid movie" do
      bad_data = movie_data.clone()
      bad_data.delete(:title)
      assert_no_difference "Movie.count" do
        post movies_url, params: { movie: bad_data }
        assert_response :bad_request
      end

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "title"
    end
  end
end
