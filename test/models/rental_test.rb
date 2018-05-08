require "test_helper"

describe Rental do
  before do
    @movie = Movie.first
    @customer = Customer.first
  end

  describe "Can be created" do
    it "with valid data" do
      old_rental_count = Rental.count

      rental = Rental.new(movie: @movie, customer: @customer)

      rental.must_be :valid?
      rental.save

      rental.must_be_kind_of Rental
      Rental.count.must_equal old_rental_count + 1
    end
  end

  describe "model methods" do
    describe "rental#create_from_request" do
      it "creates a rental" do
        checkout_date = DateTime.now
        due_date =  checkout_date + 7
        old_rental_count = Rental.count

        rental_data = {
          customer_id: @customer.id,
          movie_id: @movie.id
        }

        rental = Rental.create_from_request(rental_data)
        rental.save

        result = (rental.due_date - due_date)

        rental.must_be_kind_of Rental
        Rental.count.must_equal old_rental_count + 1
        result.must_be :<, 1
      end

      it "returns invalid rental if given invalid data" do
        old_rental_count = Rental.count
        rental_data = {
          customer_id: nil,
          movie_id: @movie.id
        }

        rental = Rental.create_from_request(rental_data)

        rental.wont_be :valid?
        Rental.count.must_equal old_rental_count
      end
    end

  end

  describe "relationships" do
    before do
      @rental = Rental.create!(movie: @movie, customer: @customer)
    end

    it "ties rentals and customer" do
      result = @rental.customer

      result.must_be_kind_of Customer
      result.id.must_equal @customer.id
    end

    it "ties rentals and movies" do
      result = @rental.movie

      result.must_be_kind_of Movie
      result.id.must_equal @movie.id
    end

  end
end
