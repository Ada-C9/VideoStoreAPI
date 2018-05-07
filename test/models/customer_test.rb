require "test_helper"

describe Customer do
  describe "validations" do
    # all validations pass
    before do
      customer = Customer.first


      @customer = Customer.new(
        name: "Movie Watcher",
        address: "2015-04-29T14:54:14.000Z",
        city: "Seattle",
        state: "WA",
        postal_code: "98109",
        phone: "555-555-5555")
      end

      it "can be created will all required fields" do
        # Act
        result = @customer.valid?

        # Assert
        result.must_equal true

      end

      it "is invalid without a name" do
        @customer.name = nil

        result = @customer.valid?

        result.must_equal false
        @customer.errors.messages.must_include :name
      end

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
