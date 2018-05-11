require "test_helper"
require "date"

describe Rental do
  let(:rental) { Rental.new }

  describe "validations" do
    it "must be valid" do
      rental_one = rentals(:rental_one)
      rental_one.valid?.must_equal true
    end

    it "must be valid if returned is true" do
      rental_two = rentals(:rental_two)
      rental_two.valid?.must_equal true
    end

    it "must be invalid if due date, customer, and movie are blank" do
      rental_three = rentals(:rental_three)
      rental_three.valid?.must_equal false
    end
  end

  describe "relations" do
    it "must have a Customer" do
      rental_one = rentals(:rental_one)
      rental_one.must_respond_to :customer
      rental_one.customer.must_be_kind_of Customer
      rental_one.customer.name.must_equal "Shelley Rocha"
      rental_one.customer.must_equal customers(:shelley)
    end

    it "must have a Movie" do
      rental_one = rentals(:rental_one)
      rental_one.must_respond_to :movie
      rental_one.movie.must_be_kind_of Movie
      rental_one.movie.title.must_equal "Blacksmith Of The Banished"
      rental_one.movie.must_equal movies(:blacksmith)
    end
  end

  describe "assign_due_date" do
    let(:rental) { rentals(:rental_one) }

    it "can assign a due date" do
      rental.due_date = nil
      rental.due_date.must_equal nil
      rental.assign_due_date
      rental.due_date.must_be_kind_of Date
    end

    it "can assign a due date 7 days from Rental creation" do
      rental.due_date = nil
      rental.due_date.must_equal nil
      rental.assign_due_date
      rental.due_date.must_equal rental.created_at.to_date + 7
    end
  end
end
