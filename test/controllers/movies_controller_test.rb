require "test_helper"
require 'pry'
describe MoviesController do
  describe 'Index' do
    it "should get index" do
      get movies_url
      must_respond_with :success
    end

    it "should still return success if there are no movies" do
      Movie.destroy_all
      Movie.count.must_equal 0
      get movies_url
      must_respond_with :success
    end

    it "should return json" do
      get movies_url
      response.header['Content-Type'].must_include "json"
    end

    it "should return an array" do
      get movies_url
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all of the movies" do
      get movies_url

      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end
  end

  describe "Show" do
    it 'can show a movie' do
      a_movie = movies(:Phantom)
      get movie_url(a_movie.id)

      must_respond_with :success

      JSON.parse(response.body)["title"].must_equal "Phantom Thread"
      JSON.parse(response.body)["overview"].must_equal nil
      JSON.parse(response.body)["release_date"].must_equal "2016-02-03T00:00:00.000Z"
      JSON.parse(response.body)["inventory"].must_equal 12
      JSON.parse(response.body)["available_inventory"].must_equal 12
    end

    it 'will render a 404 for a non-existant ID' do
      non_existant_ID = -1
      get movie_url(non_existant_ID)

      JSON.parse(response.body)["ok"].must_equal false
      must_respond_with :not_found

    end
  end

  describe "Create" do
    it 'can post a movie with valid data' do
      proc{
        post movies_url,
          params:{

                      title:"test movie",overview: "testing",release_date:DateTime.now,inventory:12,available_inventory:11
                    }

            }.must_change 'Movie.count', 1

      JSON.parse(response.body)["id"].must_equal 1072689925
      must_respond_with :success
    end

    it 'will return bad-request for post request with bad data' do

      proc{
        post movies_url,
          params:{
                      title:"",overview: "testing",release_date: DateTime.now,inventory:12,available_inventory:11
                    }
            }.wont_change 'Movie.count'

      must_respond_with :bad_request
      JSON.parse(response.body)["ok"].must_equal false
      JSON.parse(response.body)["error"]["title"][0].must_equal "can't be blank"
    end
  end
end
