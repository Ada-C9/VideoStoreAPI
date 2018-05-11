require "test_helper"

describe Rental do
  let(:rental) { Rental.new }
  let(:rental1) { rentals(:one) }

  describe "relations" do
    it "has a customer" do
      rental1.must_respond_to :customer
      rental1.customer.must_be_kind_of Customer
      rental1.customer.must_equal customers(:mary)
    end
    it "has a movie" do
      rental1.must_respond_to :movie
      rental1.movie.must_be_kind_of Movie
      rental1.movie.must_equal movies(:one)
    end

    it "changes in customer_id and movie_id reflects in customer and movie" do
      rental1.customer_id = customers(:sally).id
      rental1.customer.must_equal customers(:sally)

      rental1.movie_id = movies(:two).id
      rental1.movie.must_equal movies(:two)
    end
  end

  describe "validations" do
    it "has validation for empty parameters" do
      rental.valid?.must_equal false
    end

    it "has validation for due_date presence" do
      rental1.due_date = nil
      rental1.valid?.must_equal false
      rental1.errors.messages.must_include :due_date

      rental1.due_date = ""
      rental1.valid?.must_equal false
      rental1.errors.messages.must_include :due_date
    end

    it "has validation for checkout_date presence" do
      rental1.checkout_date = nil
      rental1.valid?.must_equal false
      rental1.errors.messages.must_include :checkout_date

      rental1.checkout_date = ""
      rental1.valid?.must_equal false
      rental1.errors.messages.must_include :checkout_date
    end

    it "must be valid" do
      rental1.valid?.must_equal true
    end
  end
end
