require "test_helper"

describe Rental do
  before do
    date = Date.today
    @rental_data = {
      check_out: date,
      due_date: date + 7,
      customer_id: Customer.first.id,
      movie_id: Movie.first.id
    }
  end

  it 'can be created with all valid information' do
    skip
  end

  it 'cannot be created without customer_id' do
    skip
  end

  it 'cannot be created without movie_id' do
    skip
  end

  it 'cannot be created without check_out date' do
    skip
  end

  it 'cannot be created without due_date' do
    skip
  end
end
