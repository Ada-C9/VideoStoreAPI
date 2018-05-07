require "test_helper"

describe Customer do
  let(:customer) { Customer.new }
  let(:customer) { customers(:Mary)}

  describe "relations" do
    it "has a list of rentals" do
      mary = customers(:mary)
      mary.must_respond_to :rentals
      mary.rentals.each do |rental|
        mary.must_be_kind_of Rental
      end
    end

  end

  it "must be valid" do



  end
end
