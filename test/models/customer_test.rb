require "test_helper"

describe Customer do
  describe "validations" do

  end

  describe "relations" do
    before do
      @customer = Customer.new(
        name: "Movie Watcher",
        address: "2015-04-29T14:54:14.000Z",
        city: "Seattle",
        state: "WA",
        postal_code: "98109",
        phone: "555-555-5555"
      )
    end

    it "has movies" do
      
    end
  end
end
