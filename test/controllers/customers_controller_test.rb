require "test_helper"

describe CustomersController do
  it "should get index" do
    get customers_path

    must_respond_with :success?
  end

  it "should get show" do
    get customers_show_url
    value(response).must_be :success?
  end

end
