require "test_helper"

describe MoviesController do
  describe 'index' do
    it "responds with success" do
      get movies_path
      must_respond_with :success
    end

    it "returns " do
      get movies_path
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an array " do
      get movies_path

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      must_respond_with :success
    end
     it "returns all of the movies" do
       get movies_path

       body = JSON.parse(response.body)
       body.length.must_equal Movie.count
       must_respond_with :success
     end

  end

  describe 'show' do

  end


end
