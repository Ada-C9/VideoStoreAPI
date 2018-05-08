require "test_helper"

describe Rental do
  before do
    @rental = Rental.new(
      movie: movies(:LOTR),
      customer: customers(:dan),
      check_out: DateTime.now,
      due_date: DateTime.now + 7
    )
  end

  it "can be created with all required fields" do
    count_before = Rental.count
    @rental.valid?.must_equal true

    @rental.save

    Rental.last.movie.id.must_equal movies(:LOTR).id
    Rental.count.must_equal count_before + 1
  end

  it "is invalid without a movie ID" do
    count_before = Rental.count
    @rental.movie_id = nil
    @rental.valid?.must_equal false

    @rental.save

    @rental.errors.messages.must_include :movie_id
    Rental.count.must_equal count_before
  end

  it "is invalid without a customer ID" do
    count_before = Rental.count
    @rental.customer_id = nil
    @rental.valid?.must_equal false

    @rental.save

    @rental.errors.messages.must_include :customer_id
    Rental.count.must_equal count_before
  end

  it "is invalid without a check out date" do
    count_before = Rental.count
    @rental.check_out = nil
    @rental.valid?.must_equal false

    @rental.save

    @rental.errors.messages.must_include :check_out
    Rental.count.must_equal count_before
  end

  it "is invalid without a due date" do
    count_before = Rental.count
    @rental.due_date = nil
    @rental.valid?.must_equal false

    @rental.save

    @rental.errors.messages.must_include :due_date
    Rental.count.must_equal count_before
  end

  it "is invalid if the due date is before the check out date" do
    count_before = Rental.count
    @rental.due_date = DateTime.now
    @rental.check_out = DateTime.now + 1
    @rental.valid?.must_equal false

    @rental.save

    @rental.errors.messages.must_include :due_date
    Rental.count.must_equal count_before
  end

  it "is invalid if the check in date is before the check out date" do
    count_before = Rental.count
    @rental.check_in = DateTime.now
    @rental.check_out = DateTime.now + 1
    @rental.valid?.must_equal false

    @rental.save

    @rental.errors.messages.must_include :check_in
    Rental.count.must_equal count_before
  end
end
