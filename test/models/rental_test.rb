require "test_helper"

describe Rental do
  let(:rental) {rentals(:one) }

  describe "validations" do

    it "must be valid" do
      value(rental).must_be :valid?
    end

    it "must have checkout_date" do
      rental.checkout_date = nil
      rental.valid?.must_equal false
    end

    it "must have due_date" do
      rental.due_date = nil
      rental.valid?.must_equal false
    end

    it "must have 7 day difference between checkout and due dates" do
      checkout= Date.parse(rental.checkout_date)
      due = Date.parse(rental.due_date)
      (checkout...due).count.must_equal 7
    end
  end

  describe "relationships" do
    it "must have a customer" do
      rental.customer.must_equal customers(:one)

      rental.customer = nil
      rental.valid?.must_equal false
    end

    it "must have a movie" do
      rental.movie.must_equal movies(:one)

      rental.movie = nil
      rental.valid?.must_equal false
    end
  end
end
