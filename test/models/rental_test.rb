require "test_helper"

describe Rental do
  describe 'relations' do
    let(:rental) { rentals(:rental) }

    it "has a movie" do
      rental = Rental.new(due_date: "10-02-2018")
      movie = Movie.first
      rental.movie = movie
      rental.customer = Customer.first

      rental.movie_id.must_equal movie.id
    end

    it 'has a customer' do
      rental = Rental.new(due_date: "10-02-2018")
      customer = Customer.first
      rental.movie = Movie.first
      rental.customer = customer

      rental.customer_id.must_equal customer.id
    end
  end
  describe 'validations' do
      it "must be a valid rental" do
        rental = Rental.new(due_date: "10-02-2018")
        rental.customer = Customer.first
        rental.movie = Movie.first
        rental.valid?.must_equal true
      end
      it "is invalid without a customer" do
        rentals(:rental).customer = nil
        rentals(:rental).valid?.must_equal false
    end
  end
  describe 'rental_date' do
    it 'can set a checkout date' do
      checkout = Date.today
      due = Date.today + 7
      rental = Rental.new(due_date: due)
      rental.due_date.must_equal checkout + 7
    end
  end
  describe 'build rental' do
    it 'updates inventory, customer checked out count, and status for newly rented movie' do
      rental = Rental.new(due_date: "10-02-2018")
      rental.movie = Movie.first
      rental.customer = Customer.first

      rental.movie.available_inventory = 7
      rental.customer.movies_checked_out_count = 5
      rental.checked_out = false

      Rental.build_rental(rental)
      Movie.first.available_inventory.must_equal 6
      Customer.first.movies_checked_out_count.must_equal 6
      rental.checked_out.must_equal true
    end
    it 'will not update any information bogus rental' do
      rental = Rental.new(due_date: "10-02-2018")
      movie = Movie.first
      rental.movie = movie
      rental.customer = nil
      movie.available_inventory = 7

      proc { Rental.build_rental(rental) }.must_raise
    end
  describe 'build return' do
    it 'updates inventory, customer checked out count, and status for returned movie' do
      rental = Rental.new(due_date: "10-02-2018")
      rental.movie = Movie.first
      rental.customer = Customer.first

      rental.movie.available_inventory = 1
      rental.customer.movies_checked_out_count = 50
      rental.checked_out = true

      Rental.build_return(rental)
      Movie.first.available_inventory.must_equal 2
      Customer.first.movies_checked_out_count.must_equal 49
      rental.checked_out.must_equal false
    end
    it 'will not update any information bogus return' do
      rental = Rental.new(due_date: "10-02-2018")
      customer = Customer.first
      rental.movie = nil
      rental.customer = Customer.first
      customer_movies = customer.movies_checked_out_count

      proc { Rental.build_return(rental) }.must_raise
      customer_movies.must_equal Customer.first.movies_checked_out_count
    end
  end
  end
end
