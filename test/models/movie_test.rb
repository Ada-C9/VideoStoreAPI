require "test_helper"

describe Movie do
  describe 'relations' do

    it 'can connect movie to customer_id' do
      customer = Customer.create!(name: "test customer")
      movie = Movie.new(title: "test movie")
      movie.customers << customer
      movie.customers.last.id.must_equal customer.id
    end

    it "must be valid" do
      value(movie).must_be :valid?
    end
  end
end
