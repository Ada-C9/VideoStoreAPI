require "test_helper"

describe Customer do

  describe 'validations' do
    let(:shelley) { customers(:shelley) }

    it "must be valid" do
      value(shelley).must_be :valid?
    end

    it "must have a name" do
      shelley.name = nil
      shelley.valid?.must_equal false
    end

    it "must have a phone" do
      shelley.phone = nil
      shelley.valid?.must_equal false
    end

    it "must have a address" do
      shelley.phone = nil
      shelley.valid?.must_equal false
    end

    it "must have a city" do
      shelley.phone = nil
      shelley.valid?.must_equal false
    end

    it "must have a state" do
      shelley.phone = nil
      shelley.valid?.must_equal false
    end

    it "must have a postal_code" do
      shelley.phone = nil
      shelley.valid?.must_equal false
    end

    it "must have a phone" do
      shelley.phone = nil
      shelley.valid?.must_equal false
    end
  end

  describe 'relations' do
    let(:shelley) { customers(:shelley) }
    it 'can have many rentals' do
      shelley.must_respond_to :rentals
    end
  end

  describe 'movies_checked_out_count' do
    let(:shelley) { customers(:shelley) }

    it 'can be called' do
      shelley.must_respond_to :movies_checked_out_count
    end

    it 'returns the number of 0 if costumer has no rental not returned' do
      Rental.destroy_all

      shelley.movies_checked_out_count.must_equal 0
    end

    it 'returns the number of rentals a costumer has that are not returned yet' do
        Rental.destroy_all
      Rental.create(customer_id: shelley.id, movie_id: movies(:blacksmith).id)

      shelley.movies_checked_out_count.must_equal 1
    end

    it 'returns the number of 0 rentals if a costumer has only rentals that has been returned already' do
        Rental.destroy_all
      rental = Rental.create(customer_id: shelley.id, movie_id: movies(:blacksmith).id)
      rental.update_attributes(returned: true)

      shelley.movies_checked_out_count.must_equal 0
    end
  end
end
