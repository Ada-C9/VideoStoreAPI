require "test_helper"

describe Rental do
  before do
  end

  describe "validations" do
    it 'will raise an error with a missing customer_id' do
    end

    it 'will raise an error with a missing movie_id' do
    end

    it 'will raise an error with a missing check_in' do
    end

    it 'will raise an error with a missing check_out' do
    end
  end

  describe "relations" do
    it 'belongs to a customer' do
    end

    it 'belongs to a movie' do
    end
  end

end
# describe Rental do
#   let(:rental) { Rental.new }
#
#   it "must be valid" do
#     value(rental).must_be :valid?
#   end
# end
