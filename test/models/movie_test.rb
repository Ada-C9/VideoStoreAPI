require "test_helper"

describe Movie do
  describe "validations" do
    # all validations pass
    before do
      # Arrange


      @movie = Movie.new(
        title: "test movie",
        overview: "The unexciting life of a boy",
        release_date: "1979-01-18",
        inventory: "10"
      )

      customer = Customer.first
      rental_data = { movie_id: @movie.id, customer_id: customer.id}

      rental = Rental.create(rental_data)
      end

      it "can be created will all required fields" do
        # Act
        result = @movie.valid?

        # Assert
        result.must_equal true


      end

      # no title -> fail
      it "is invalid without a title" do
        @movie.title = nil

        result = @movie.valid?

        result.must_equal false
        @movie.errors.messages.must_include :title
      end

      # duplicate title -> fail
      it "is invalid with a duplicate title" do
        dup_movie = Movie.first
        @movie.title = dup_movie.title

        result = @movie.valid?

        result.must_equal false
        @movie.errors.messages.must_include :title
      end
    end

    describe "relations" do
      before do
        @movie = Movie.create(
          title: "test movie",
          overview: "The unexciting life of a boy",
          release_date: "1979-01-18",
          inventory: "10",
          available_inventory: "8"
        )

        customer = Customer.first
        rental_data = { movie_id: @movie.id, customer_id: customer.id}

        rental = Rental.create(rental_data)
      end

      it "has rentals" do
        @movie.rentals.count.must_equal 1
      end
    end

    describe "available_to_rent?" do
      before do
        @movie = Movie.create(
          title: "test movie",
          overview: "The unexciting life of a boy",
          release_date: "1979-01-18",
          inventory: "10",
          available_inventory: "10"
        )

        customer = Customer.first
        rental_data = { movie_id: @movie.id, customer_id: customer.id}

        rental = Rental.create(rental_data)
      end

      it "returns true if the movie has available inventory" do
        @movie.available_inventory.must_be :>, 0

        @movie.available_to_rent?.must_equal true
      end

      it "returns false if the movie does not have available inventory" do
        @movie.inventory.times do
          @movie.reduce_available_inventory
        end

        @movie.reload
        @movie.available_inventory.must_equal 0

        @movie.available_to_rent?.must_equal false
      end
    end


    describe "reduce_available_inventory" do
      it "reduce_available_inventory" do
          @movie = Movie.create(
            title: "test movie",
            overview: "The unexciting life of a boy",
            release_date: "1979-01-18",
            inventory: "10",
            available_inventory: "8"
          )

          available_inventory = @movie.available_inventory
          customer = Customer.first
          rental_data = { movie_id: @movie.id, customer_id: customer.id}
          rental = Rental.create(rental_data)
          @movie.reduce_available_inventory
          @movie.available_inventory.must_equal available_inventory - 1

      end
    end

    describe "increase_available_inventory" do
      it "increase_available_inventory" do
          @movie = Movie.create(
            title: "test movie",
            overview: "The unexciting life of a boy",
            release_date: "1979-01-18",
            inventory: "10",
            available_inventory: "8"
          )

          available_inventory = @movie.available_inventory
          customer = Customer.first
          rental_data = { movie_id: @movie.id, customer_id: customer.id}
          rental = Rental.create(rental_data)
          @movie.increase_available_inventory
          @movie.available_inventory.must_equal available_inventory + 1

      end
    end

  end
