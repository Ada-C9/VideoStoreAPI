require "test_helper"

describe Movie do
  describe "relations" do
    it "has a collection of rentals" do
      movie = movies(:HP)
      movie.must_respond_to :rentals
      movie.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end
    end
  end

  describe "validations" do
    before do
      @movie = Movie.new(
        title: "Wonder Woman",
        overview: "I don't feel like writing this",
        release_date: Date.parse("05/07/18"),
        inventory: 3
      )
    end

    it "must be valid with all required fields" do
      count_before = Movie.count
      @movie.valid?.must_equal true

      @movie.save

      Movie.last.title.must_equal @movie.title
      Movie.count.must_equal count_before + 1
    end

    it "is invalid without a title and does not update DB" do
      count_before = Movie.count
      @movie.title = nil
      @movie.valid?.must_equal false

      @movie.save

      @movie.errors.messages.must_include :title
      Movie.count.must_equal count_before
    end

    it "is invalid without an overview and does not update DB" do
      count_before = Movie.count
      @movie.overview = nil
      @movie.valid?.must_equal false

      @movie.save

      @movie.errors.messages.must_include :overview
      Movie.count.must_equal count_before
    end

    it "is invalid without a release date and does not update DB" do
      count_before = Movie.count
      @movie.release_date = nil
      @movie.valid?.must_equal false

      @movie.save

      @movie.errors.messages.must_include :release_date
      Movie.count.must_equal count_before
    end

    it "is invalid without an inventory and does not update DB" do
      count_before = Movie.count
      @movie.inventory = nil
      @movie.valid?.must_equal false

      @movie.save

      @movie.errors.messages.must_include :inventory
      Movie.count.must_equal count_before
    end

    it "is invalid if inventory is less than 0 and does not update DB" do
      count_before = Movie.count
      @movie.inventory = -2
      @movie.valid?.must_equal false

      @movie.save

      @movie.errors.messages.must_include :inventory
      Movie.count.must_equal count_before
    end

    # it "is invalid if available inventory is less than 0" do
    #   count_before = Movie.count
    #   @movie.available_inventory = -2
    #   @movie.valid?.must_equal false
    #
    #   @movie.save
    #
    #   @movie.errors.messages.must_include :available_inventory
    #   Movie.count.must_equal count_before
    # end
  end

  # describe "inventory_available?" do
  #   it "returns true if the movie has available inventory" do
  #     movie = movies(:HP)
  #
  #     movie.inventory_available?.must_equal true
  #     movie.inventory.must_equal 3
  #   end
  #
  #   it "returns false if the movie has not available inventory" do
  #     movie = movies(:LOTR)
  #     movie.inventory = 0
  #
  #     movie.inventory_available?.must_equal false
  #   end
  # end
  #
  #
  # describe "inventory_check_out" do
  #   it "successfully decrease the movie's available inventory" do
  #     movie = movies(:HP)
  #     movie.available_inventory = movie.inventory
  #     inventory_before = movie.available_inventory
  #
  #     movie.inventory_check_out
  #     movie.available_inventory.must_equal  inventory_before - 1
  #   end
  #
  #   it "successfully decrease the movie's available inventory and check what happens" do
  #     movie = movies(:LOTR)
  #     movie.available_inventory = movie.inventory
  #     inventory_before = movie.available_inventory
  #
  #     movie.update(available_inventory: movie.inventory_check_out)
  #     movie.update(available_inventory: movie.inventory_check_out)
  #     movie.errors.messages.must_include :available_inventory
  #     movies(:LOTR).available_inventory.must_equal 0
  #   end
  # end


  describe "available_inventory" do
    it "shows that the available inventory is the same as the inventory if movie is not checked out" do
      movie = movies(:HP)

      movie.available_inventory.must_equal movie.inventory
    end

    it "will decreate the available inventory when the movie is checked out" do
      movie = movies(:LOTR)

      movie.available_inventory.must_equal movie.inventory - 1
    end 

  end
end
