require "test_helper"

describe RentalsController do
  describe 'checkout' do
    it 'is real route' do
      skip
    end

    it 'can checkout a movie' do
      skip
    end

    it 'assigns a checkout date' do
      skip
    end

    it 'changes the due date to 7 days from the checkout date' do
      skip
    end

    it 'changes inventory of movie with creation of a new checkout' do
      skip
    end

    it 'throws an error if inventory of movie is 0 and someone tries to checkout' do
      skip
    end
  end

  describe 'checkin' do
    it 'is real route' do
      skip
    end

    it 'can checkin a movie' do
      skip
    end

    it 'changes the inventory of movie when it is checked in' do
      skip
    end

    it 'throws an error if a movie is not checked out and you attempt a checkin' do
      skip
    end
  end
end
