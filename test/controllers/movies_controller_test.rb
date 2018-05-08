require "test_helper"

describe MoviesController do
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
