require "test_helper"

describe Rental do
  let(:rental) { rentals(:one) }


  it "must be valid" do
    # TODO set up rental YML file with a customer and movie -- using the yml called ":one" and then run this test again
    value(rental).must_be :valid?
  end
end
