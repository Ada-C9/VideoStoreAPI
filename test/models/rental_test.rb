require "test_helper"

describe Rental do
  let(:rental) { Rental.new(movie_id: movies(:bride).id, customer_id: customers(:ada).id, checkout_date: Date.today, due_date: Date.today + 7)}

  it "must be valid" do
    value(rental).must_be :valid?
  end
end
