require "test_helper"

describe Rental do
  let(:rental) { Rental.new }
  let(:one) { rentals(:one) }

  it "exists" do
    one.valid?.must_equal true
  end
end
