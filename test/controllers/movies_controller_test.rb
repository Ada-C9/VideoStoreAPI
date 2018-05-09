require "test_helper"

describe MoviesController do
  describe 'index'do

  it "is a real working route" do
    get movies_url
    must_respond_with :success
  end

  it "returns json" do
    get movies_url
    response.header['Content-Type'].must_include 'json'
  end

  it "returns an Array" do
    get movies_url

    body = JSON.parse(response.body)
    body.must_be_kind_of Array
  end

  it "returns all of the movies" do
    get movies_url

    body = JSON.parse(response.body)
    body.length.must_equal Movie.count
  end

  it "returns movies with exactly the required fields" do
    keys = %w(id release_date title)
    get movies_url
    body = JSON.parse(response.body)
    body.each do |movie|
      movie.keys.sort.must_equal keys
    end

  end
end

describe 'show' do
  it 'can get a movie' do
    keys = %w(available_inventory inventory overview release_date title)
    movie = movies(:robots)

    get movie_path(movie.id)

    must_respond_with :success
    response.header["Content-Type"].must_include 'json'
    body = JSON.parse(response.body)
    body.must_be_kind_of Hash
    body.keys.sort.must_equal keys
    body["title"].must_equal movie.title
  end

  it 'yields a not found status and returns and error if the movie DNE' do
    movie_id = Movie.last.id + 1

    get movie_path(movie_id)

    must_respond_with :not_found
    body = JSON.parse(response.body)
    body.must_be_kind_of Hash
    body.must_include "errors"
    body["errors"].must_include "id"
  end
end

describe 'create' do
  movie_data = {
    title: "Titanic",
    overview: "Oldie movie",
    release_date: "12-10-2000",
    inventory: 10,
    available_inventory: 10
  }

  it "Creates a new movie" do
    #option 1
    before_movie_count = Movie.count
    post new_movie_path, params: { movie: movie_data }
    must_respond_with :success

    Movie.count.must_equal before_movie_count + 1

    #option 2
    assert_difference "Movie.count", 1 do
      post new_movie_path, params: { movie: movie_data }
      must_respond_with :success
    end

    body = JSON.parse(response.body)
    body.must_be_kind_of Hash
    body.must_include "title"

    # Check that the ID matches
    Movie.find(body["id"]).title.must_equal movie_data.title
  end

  it "Returns an error for an invalid movie" do
    bad_data = movie_data.clone()
    bad_data.delete(:title)
    assert_no_difference "Movie.count" do
      post new_movie_path, params: { movie: bad_data }
      assert_response :bad_request
    end

    body = JSON.parse(response.body)
    body.must_be_kind_of Hash
    body.must_include "errors"
    body["errors"].must_include "title"
  end
end
end
