require "test_helper"

describe MoviesController do

  describe 'index' do

    it "successfully returns json containing a collection of all movies " do
      get movies_url
      must_respond_with :success
      response.header['Content-Type'].must_include 'json'
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      body.length.must_equal Movie.count
    end

    it "returns movies with the required fields" do
      get movies_url
      keys = %w(id release_date title)
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys
      end
    end

    it "returns an empty array if there are no movies" do
      Movie.destroy_all
      get movies_url
      body = JSON.parse(response.body)
      body.must_equal []
    end

  end

  describe 'show' do
    before do
      @movie = movies(:one)
    end

    it "successfully returns json containing a hash with information for one movie " do
      get movie_path(@movie.id)
      must_respond_with :success
      response.header['Content-Type'].must_include 'json'
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
    end

    it "locates the correct movie" do
      get movie_path(@movie.id)
      body = JSON.parse(response.body)
      body["title"].must_equal @movie.title
      body["overview"].must_equal @movie.overview
    end

    it "returns a movie with all the requested fields" do
      keys = %w(available_inventory inventory overview release_date title)
      get movie_path(@movie.id)
      body = JSON.parse(response.body)
      body.keys.sort.must_equal keys
    end

    it "renders not_found and displays errors if the movie does not exist" do
      bad_movie_id = Movie.last.id + 1
      get movie_path(bad_movie_id)

      must_respond_with :not_found

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "id"
    end

  end

  describe 'create' do

    let(:movie_data) {
      {
        title: "test_title",
        overview: "what a movie",
        release_date: "2018-05-08",
        inventory: 4
      }
    }

    it 'can create a new movie with valid data' do

      old_movie_count = Movie.count


      post movies_url, params: { movie: movie_data}

      must_respond_with :success

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "id"

      Movie.find(body["id"]).title.must_equal movie_data[:title]

      Movie.count.must_equal old_movie_count + 1

    end

    it 'responds with bad_request and error messages if no title' do

      bad_title_data = {
        title: nil,
        overview: "what a movie",
        release_date: "2018-05-08",
        inventory: 4
      }

      post movies_url, params: { movie: bad_title_data }

      must_respond_with :bad_request

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "title"

    end

    it 'responds with bad_request and error messages if invalid inventory info' do

      bad_inventory_data = {
        title: "Movie!",
        overview: "what a movie",
        release_date: "2018-05-08",
        inventory: "gh"
      }

      post movies_url, params: { movie: bad_inventory_data }

      must_respond_with :bad_request

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "inventory"

    end
  end


end
