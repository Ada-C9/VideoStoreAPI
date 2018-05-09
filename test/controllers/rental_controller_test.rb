require "test_helper"

describe RentalController do
  it "should get check_in" do
    post check_out_path, params:{
      "customer_id": nil,
      "movie_id": movies(:Lion).id
    }

    value(response).must_be :success?
  end

  # it "should get check_out" do
  #   get rental_check_out_url
  #   value(response).must_be :success?
  # end

end
