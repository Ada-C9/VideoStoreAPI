require "test_helper"

describe Customer do
  let(:jane) {customers(:jane)}
  let(:ava) {customers(:ava)}

  describe 'relations' do
    it 'checks that a customer already exists' do
      customer = Customer.find_by(name: "ava")
      customer.must_be_nil
    end

    it "connects customer and rental customer_id" do
      movie = Movie.first
      customer = Customer.first
      rental = Rental.new(movie_id: movie.id, customer_id: customer.id)
      rental.customer_id.must_equal customer.id
    end
  end

  describe 'validations' do
    it "can be created with valid info" do
      
    end

    it "must have a name to be valid" do
      jane.name = nil
      jane.valid?.must_equal false
    end

    it 'is invalid if movies_checked_out_count is less than zero' do
      # cannot be created with 0
    end
  end
end
