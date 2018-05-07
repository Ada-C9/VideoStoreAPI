require "test_helper"

describe CustomersController do
  it "is a real working route" do
    get customers_url
    must_respond_with :success
  end
end
