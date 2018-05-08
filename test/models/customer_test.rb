require "test_helper"

describe Customer do
  let(:customer) { Customer.new }

  it "must be valid" do
    jane = customers(:jane)
    value(jane).must_be :valid?
  end

  it 'nameless customers are invalid' do
    no_name = customers(:no_name)
    value(no_name).must_be :invalid?
  end

  # Test example: no phone number at all

  # Test example if we have phone number validation:
    # duplicate phone number - same as Jane, for example, but with her same phone number


  describe 'relations' do
    # use YML - customer that already exists
    it 'checks that a customer already exists' do
      ava = customers(:ava)
      value(ava).must_be :valid?
    end

    # it 'checks that a customer has rented a movie' do
    #   ava = customers(:ava)
    #   beautiful = movie(:beautiful)
    #
    #   old_rental_count
    #
    #   value(ava).must
    # end

    # use YML for movies

    # use YML movie, see if customer has rented movie, try to rent it again

    # use YML movie, see if customer has rented movie (.rent method, for example) - make new entry in customermovies

    # starts out with no rentals
    # jane.movies.length = 0

  end
end
