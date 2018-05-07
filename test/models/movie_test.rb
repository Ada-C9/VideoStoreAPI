require "test_helper"

describe Movie do
  describe 'validations' do

    before do
      @movie = Movie.new(title: 'test movie', inventory: 1, available_inventory: 1)
    end

    it "is valid when all required fields are present" do
      result = @movie.valid?
      result.must_equal true
    end

    it "is invalid without a title" do
      @movie.title = nil
      result = @movie.valid?
      result.must_equal false
      @movie.errors.messages.must_include :title
    end

    it "is invalid if the inventory is less than 1 " do
      @movie.inventory = 0
      result = @movie.valid?
      result.must_equal false
      @movie.errors.messages.must_include :inventory
    end

    it "is invalid if the available inventory is not a number" do
      @movie.available_inventory = nil
      result = @movie.valid?
      result.must_equal false
      @movie.errors.messages.must_include :available_inventory
    end

  end
end
