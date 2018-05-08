require "test_helper"

describe MoviesController do
    describe "index" do
      it "returns an array of json" do
        get movies_url
        must_respond_with :success
        response.header['Content-Type'].must_include 'json'
        body = JSON.parse(response.body)
        body.must_be_kind_of Array
      end

      it "returns movies with a name that matches the search" do
        skip
        get movies_url, params: {search: "Bob Esponja"}
        body = JSON.parse(response.body)
        body.each do |customer|
          customer["name"].must_equal "Bob Esponja"
        end
      end

      it "returns movies with exactly the required fields" do
        skip
        keys = %w(address city name phone postal_code registered_at state)
        get movies_url, params: {search: "Bob Esponja"}
        body = JSON.parse(response.body)
        body.each do |customer|
          customer.keys.sort.must_equal keys
        end
      end


    end # index
end
