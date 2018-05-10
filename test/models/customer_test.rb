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
        @customer = Customer.create(
          name: "Movie Watcher",
          address: "2015-04-29T14:54:14.000Z",
          city: "Seattle",
          state: "WA",
          postal_code: "98109",
          phone: "555-555-5555"
        )

        movie = Movie.first
        rental_data = { movie_id: movie.id, customer_id: @customer.id}

        rental = Rental.create(rental_data)

      end

      it "has movies" do
        @customer.rentals.count.must_equal 1
      end
    end

    describe "decrease_movies_checked_out_count" do
      it "decrease_movies_checked_out_count" do
        @customer = Customer.create(
          name: "Movie Watcher",
          address: "2015-04-29T14:54:14.000Z",
          city: "Seattle",
          state: "WA",
          postal_code: "98109",
          phone: "555-555-5555",
          movies_checked_out_count: 3
        )

          customer_movies_checked_out_count = @customer.movies_checked_out_count
          movie = Movie.first
          rental_data = { movie_id: movie.id, customer_id: @customer.id }
          rental = Rental.create(rental_data)
          @customer.decrease_movies_checked_out_count
          @customer.movies_checked_out_count.must_equal customer_movies_checked_out_count - 1

      end
    end

    describe "increase_movies_checked_out_count" do
      it "increase_movies_checked_out_count" do
        @customer = Customer.create(
          name: "Movie Watcher",
          address: "2015-04-29T14:54:14.000Z",
          city: "Seattle",
          state: "WA",
          postal_code: "98109",
          phone: "555-555-5555",
          movies_checked_out_count: 3
        )

        customer_movies_checked_out_count = @customer.movies_checked_out_count
        movie = Movie.first
        rental_data = { movie_id: movie.id, customer_id: @customer.id }
        rental = Rental.create(rental_data)
        @customer.increase_movies_checked_out_count
        @customer.movies_checked_out_count.must_equal customer_movies_checked_out_count + 1

      end
    end

  end
