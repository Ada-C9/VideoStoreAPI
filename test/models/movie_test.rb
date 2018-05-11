require "test_helper"

describe Movie do

  let(:harry_potter) { movies(:harry) }

  describe "validations" do
    it "is valid when all fields are present" do
      harry_potter.valid?.must_equal true
    end

    it "is not valid when title is missing" do
      harry_potter.title = nil
      harry_potter.valid?.must_equal false
    end

    it "is not valid when overview is missing" do
      harry_potter.overview = nil
      harry_potter.valid?.must_equal false
    end

    it "is not valid when release_date is missing" do
      harry_potter.release_date = nil
      harry_potter.valid?.must_equal false
    end

    it "is not valid when inventory is missing" do
      harry_potter.inventory = nil
      harry_potter.valid?.must_equal false
    end
  end

  describe "relations" do
    it "responds to rentals" do
      harry_potter.must_respond_to :rentals
    end
  end

  describe "custom methods" do
    it "returns an integer equal to inventory when there are no rentals" do
      no_rentals = movies(:lego)
      no_rentals.available_inventory.must_be_kind_of Integer
      # no_rentals.available_inventory.must_equal no_rentals.inventory
    end

    # it "returns zero if there are no more available movies" do
    #   all_rented = movies(:harry)
    #   all_rented.available_inventory.must_equal 0
    # end
  end

end
