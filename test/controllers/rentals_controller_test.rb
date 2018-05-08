require "test_helper"

describe RentalsController do
  it "should get new" do
    get rentals_new_url
    value(response).must_be :success?
  end

  it "should get update" do
    get rentals_update_url
    value(response).must_be :success?
  end

end
