require "test_helper"

describe MoviesController do
  describe 'movies#zomg' do
    it "responds with ok" do
    get zomg_path

    must_respond_with :ok
  end
end

describe "movies#index" do
  it "gets index" do
    get movies_path
    must_respond_with :success
  end

  it "sends json with a collection of movies" do
    get movies_path
    response.header['Content-Type'].must_include 'json'

    body = JSON.parse(response.body)

    body.must_be_kind_of Array
    body.length.must_equal Movie.count
  end

  it "returns with the exact fields required" do
    keys = %w(available_inventory id inventory overview release_date title)

    get movies_path

    body = JSON.parse(response.body)

    body.each do |movie|
      movie.keys.sort!.must_equal keys
    end
  end

  it "returns no content when no available movies" do
    Movie.destroy_all

    Movie.count.must_equal 0

    get movies_path

    must_respond_with :not_found
    body = JSON.parse(response.body)
    body.must_be_kind_of Hash
    body.must_include "errors"

    body["errors"].must_include "movie"
  end
end

describe "show " do
  it "finds existant movie" do
    movie = movies(:one)

    get movie_path(movie.id)

    must_respond_with :success

    response.header["Content-Type"].must_include 'json'

    body = JSON.parse(response.body)

    body.must_be_kind_of Hash
    body["id"].must_equal movie.id
  end

  it "responds with not found if no movie" do
    movie_id = Movie.last.id + 1

    get movie_path(movie_id)

    body = JSON.parse(response.body)

    body.must_be_kind_of Hash
    body.must_include "errors"
    body["errors"].must_include "movie"
  end
end

describe "create" do
  it "responds with ok with appropriate data" do
    param_hash = {

      title: "Test movie Title",
      inventory: 3

    }

    old_count = Movie.count
    post movies_path, params: param_hash
    must_respond_with :ok
    response.header["Content-Type"].must_include 'json'
    body = JSON.parse(response.body)
    body.must_be_kind_of Hash
    body.must_include "id"
    Movie.count.must_equal old_count + 1
    body["id"].must_equal Movie.last.id
  end

  describe "responds with bad request to inappropriate data" do
    it "inappropriate inventory" do
      param_hash = {
        movie: {
          title: "Test movie Title",
          inventory: -8
        }
      }

      old_count = Movie.count
      post movies_path, params: param_hash
      must_respond_with :bad_request
      response.header["Content-Type"].must_include 'json'
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      Movie.count.must_equal old_count
      body["errors"].must_include "inventory"
    end

    it "missing title" do
      param_hash = {
        movie: {
          title: nil,
          inventory: 6
        }
      }

      old_count = Movie.count
      post movies_path, params: param_hash
      must_respond_with :bad_request
      response.header["Content-Type"].must_include 'json'
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      Movie.count.must_equal old_count
      body["errors"].must_include "title"
    end

  end

end
end
