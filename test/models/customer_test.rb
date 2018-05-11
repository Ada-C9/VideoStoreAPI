require "test_helper"

describe Customer do
  describe "relations" do
    it "has a collection of rentals" do
      customer = customers(:dan)
      customer.must_respond_to :rentals
      customer.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end
    end
  end

  describe "validations" do
    before do
      @customer = Customer.new(
        name: "Dee",
        registered_at: DateTime.parse("5/07/2018"),
        postal_code: 98232,
        phone: "253-867-5309"
      )
    end

    it "must be valid with all required fields" do
      count_before = Customer.count
      @customer.valid?.must_equal true

      @customer.save

      Customer.last.name.must_equal @customer.name
      Customer.count.must_equal count_before + 1
    end

    it "is invalid without a name and does not update DB" do
      count_before = Customer.count
      @customer.name = nil
      @customer.valid?.must_equal false

      @customer.save

      @customer.errors.messages.must_include :name
      Customer.count.must_equal count_before
    end

    it "is invalid without a registered at and does not update DB" do
      count_before = Customer.count
      @customer.registered_at = nil
      @customer.valid?.must_equal false

      @customer.save

      @customer.errors.messages.must_include :registered_at
      Customer.count.must_equal count_before
    end

    it "is invalid without a postal code and does not update DB" do
      count_before = Customer.count
      @customer.postal_code = nil
      @customer.valid?.must_equal false

      @customer.save

      @customer.errors.messages.must_include :postal_code
      Customer.count.must_equal count_before
    end

    it "is invalid without a phone and does not update DB" do
      count_before = Customer.count
      @customer.phone = nil
      @customer.valid?.must_equal false

      @customer.save

      @customer.errors.messages.must_include :phone
      Customer.count.must_equal count_before
    end

  end

  describe "movies_checked_out_count" do
    it "returns the number of movies checked out" do
      customer = customers(:dan)

      customer.movies_checked_out_count.must_equal 1
    end

    it "returns 0 if the customer has no movies checked out" do
      customer = customers(:dee)

      customer.movies_checked_out_count.must_equal 0
    end
  end

end
