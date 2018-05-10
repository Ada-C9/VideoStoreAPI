require "test_helper"

describe RentalsController do
  describe "checkout" do
    it "can checkout a valid movie" do

    end

    it "can't checkout an invalid movie" do

    end

    it "creates a new rental" do

    end

  end

  describe "checkin" do
    it "responds with success" do
      post check_in_url
      must_respond_with :success
    end

    it "returns json" do
      post check_in_url
      response.header['Content-Type'].must_include 'json'
    end

    it "update checkin field on valid rental" do

    end

    it "does not checkin an invalid rental" do

    end
  end



end
