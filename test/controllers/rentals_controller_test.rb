require "test_helper"

describe RentalsController do
  it "should get check-out" do
    get rentals_check-out_url
    value(response).must_be :success?
  end

  it "should get check-in" do
    get rentals_check-in_url
    value(response).must_be :success?
  end

end
