require "test_helper"

describe Rental do

  describe "Relations " do

    it "relates movie, movie id, customer and customer id " do
      rental = Rental.create(
        customer: customers(:two),
        movie: movies(:one),
        due_date: Date.today + 21
      )

      rental.movie_id.must_equal movies(:one).id

      rental.customer_id.must_equal customers(:two).id
    end
  end

  describe "Validations" do
    it 'does not allow you to rent a movie if it does not have enough inventory' do
      movie = movies(:one)
      customer = customers(:one)

      movie.update(available_inventory: 0)

      rental3 = Rental.new(movie: movie, customer: customer)

      rental3.valid?.must_equal false
      rental3.errors.messages.must_include :quantity
    end

    it 'cannot be created without a customer_id' do
      rental = Rental.new(movie_id: movies(:one).id)

      rental.valid?.must_equal false
      rental.errors.messages.must_include :customer_id
    end

    it 'cannot be created without a movie_id' do
      rental = Rental.new(customer_id: customers(:one).id)

      rental.valid?.must_equal false
      rental.errors.messages.must_include :movie_id
    end
  end

  describe "business logic" do
    describe "find_checked_out_movie" do
      it "returns a checked out rental" do
        rental = rentals(:one)
        movie_id = rental.movie_id
        customer_id = rental.customer_id
        result = Rental.find_checked_out_movie(movie_id, customer_id)
        result.must_be_kind_of Rental
        result.must_equal rental
      end

      it "returns nil if the rental DNE" do
        rental = rentals(:one)
        movie_id = rental.movie_id + 100
        customer_id = rental.customer_id
        result = Rental.find_checked_out_movie(movie_id, customer_id)
        result.must_be_nil
      end
    end

    describe 'update_movie_and_customer' do
      it 'updates movie and customer inventory/counts during checkout' do
        rental = Rental.first
        movie_available_inventory = rental.movie.available_inventory
        customer_movies_count = rental.customer.movies_checked_out_count

        result = Rental.update_movie_and_customer(rental)

        result.must_equal rental
        result.movie.available_inventory.must_equal movie_available_inventory - 1
        result.customer.movies_checked_out_count.must_equal customer_movies_count + 1
      end

      it 'updates movie and customer inventory/counts during checkin' do
        rental = Rental.first
        rental.update(check_in_date: Date.today)
        
        movie_available_inventory = rental.movie.available_inventory
        customer_movies_count = rental.customer.movies_checked_out_count

        result = Rental.update_movie_and_customer(rental)

        result.must_equal rental
        result.movie.available_inventory.must_equal movie_available_inventory + 1
        result.customer.movies_checked_out_count.must_equal customer_movies_count - 1
      end
    end
  end
end
