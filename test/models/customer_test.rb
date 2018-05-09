require "test_helper"

describe Customer do
  before do
    @customer_data = {
      name: 'tester',
      phone: '(000) 000-0000'
    }
    @customer = Customer.new(@customer_data)
  end

  describe 'validations' do
    it "is valid with a name and phone number length of 14" do

      @customer.must_be :valid?
    end

    it "is invalid with no name" do
      @customer.name = nil

      @customer.wont_be :valid?
      @customer.errors.messages.must_include :name
    end

    it "is invalid with no phone number" do
      @customer.phone = nil

      @customer.wont_be :valid?
      @customer.errors.messages.must_include :phone
    end

    it "is invalid with a phone number less than 14 char" do
      @customer.phone = '3'
      @customer.wont_be :valid?
      @customer.errors.messages.must_include :phone
    end
  end

  describe 'relations' do
    it "associate correct rental with customer" do
      #Arrange
    date = Date.today
    rental = Rental.new(
      checkout: date,
      due_date: date + 7,
      customer_id: @customer.id,
      movie_id: Movie.first.id
      )

      #Assert
    rental.customer_id.must_equal @customer.id
    end

    it "is invalid if customer DNE" do
      date = Date.today
      rental = Rental.new(
        checkout: date,
        due_date: date + 7,
        customer_id: Customer.last.id + 1,
        movie_id: Movie.first.id
        )

        #Assert
      rental.wont_be :valid?
      rental.errors.messages.must_include :customer
    end
  end


end
