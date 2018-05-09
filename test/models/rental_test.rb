require "test_helper"

describe Rental do
  let(:rental) { Rental.new }

  it "must be valid with all fields" do
    value(rental).must_be :valid?

end
    it "wont be valid if there is no due date once checked out" do
      let(:rental) { Rental.new(checkout_date: DateTime.now, due_date: " ") }
      value(rental).wont_be :valid?
    end



end
