require "test_helper"

describe Rental do
  describe 'relations' do
    let(:rental) { Rental.new }
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
  describe 'build rental and return' do
    it 'updates inventory, number of movies checked out, and checkout status for newly rented movie' do
      rental = Rental.new(due_date: "10-02-2018")
      customer = Customer.first
      movie = Movie.first
      rental.movie = movie
      rental.customer = customer

      movie.available_inventory = 7
      customer.movies_checked_out_count = 5
      rental.checked_out = nil

      Rental.build_rental(rental)
      movie.available_inventory.must_equal 6
      customer.movies_checked_out_count.must_equal 6
      rental.checked_out.must_equal true
    end
    it 'updates inventory, number of movies checked out, and checkout status for a returned movie' do
      rental = Rental.new(due_date: "10-02-2018")
      customer = Customer.first
      movie = Movie.first
      rental.movie = movie
      rental.customer = customer

      movie.available_inventory = 1
      customer.movies_checked_out_count = 50
      rental.checked_out = true

      Rental.build_return(rental)
      movie.available_inventory.must_equal 2
      customer.movies_checked_out_count.must_equal 49
      rental.checked_out.must_equal false
    end
  end
end
