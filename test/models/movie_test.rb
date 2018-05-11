require "test_helper"

describe Movie do
  describe 'validations' do
    let(:movie) { movies(:blacksmith) }

    it "must be valid" do
      value(movie).must_be :valid?
    end

    it 'must have a title' do
      movie.title = nil
      movie.valid?.must_equal false
    end

    it "must have a release_date" do
      movie.release_date = nil
      movie.valid?.must_equal false
    end

    it "must have an overview" do
      movie.overview = nil
      movie.valid?.must_equal false
    end

    describe 'relations' do
      it "can have many rentals" do
        movie.must_respond_to :rentals
      end
    end

    describe 'available_inventory' do
      it "returns a count of available 'copies'" do
        Rental.destroy_all
        count = movie.inventory
        movie.available_inventory.must_equal count
      end

      it "returns the count of 0 for when all the 'copies' are rented" do
        while movie.available_inventory > 0
          Rental.create(customer_id: customers(:shelley).id, movie_id: movies(:blacksmith).id)
        end

        movie.available_inventory.must_equal 0
      end
    end

    describe 'available?' do
      it "returns true if there are at least one available copies" do
        Rental.destroy_all
        movie.inventory = 1
        movie.available?.must_equal true
      end

        it "returns false if all copies are rented" do
          Rental.destroy_all
          movie.inventory = 0
          movie.available_inventory.must_equal 0
          movie.available?.must_equal false
      end
    end
  end
end
