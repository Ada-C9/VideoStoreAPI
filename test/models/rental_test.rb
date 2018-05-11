require "test_helper"

describe Rental do

  describe "relations" do
    it "must respond to customer" do
      rental = Rental.first
      rental.must_respond_to :customer
    end

    it "must repond to movie" do
      rental = Rental.first
      rental.must_respond_to :movie
    end
  end

end
