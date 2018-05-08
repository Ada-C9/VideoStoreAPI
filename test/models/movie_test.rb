require "test_helper"

describe Movie do
  let(:movie) { Movie.new }
  let(:robots) { movies(:robots)}

  describe 'validations' do
    it "must be a valid movie" do
      robots.save
      robots.valid?.must_equal true
    end

    it "is invalid without a title" do
      robots.title = ""
      robots.valid?.must_equal false

    end

    # it "has reviews" do
    #   product = products(:product1)
    #   product.must_respond_to :reviews
    # end

  end

end
