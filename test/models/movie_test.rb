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
    describe 'relations' do
      it "has rentals " do
        robot = movies(:robots)
        robot.must_respond_to :rentals
      end

      it "has customers " do
        robot = movies(:robots)
        robot.must_respond_to :customers
      end

    end
  end

end
