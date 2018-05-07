require "test_helper"

describe MoviesController do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end
  it "is a real working route" do
    get movies_url

    must_respond_with :success
    response.header['Content-Type'].must_include 'json'
    body = JSON.parse(response.body)
    body.must_be_kind_of Array
  end

  it "returns all of the movies" do
    get movies_url

    body = JSON.parse(response.body)
    body.length.must_equal Customer.count
  end

  it "returns movies with exactly the required fields" do

  end
end
