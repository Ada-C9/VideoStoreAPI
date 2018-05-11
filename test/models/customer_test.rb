require "test_helper"

describe Customer do
  let(:jane) {customers(:jane)}
  let(:ava) {customers(:ava)}

  describe 'relations' do
    it 'checks that a customer already exists' do
      ava = customers(:ava)
      value(ava).must_be :valid?
    end
  end

  describe 'validations' do
    it "can be created with valid info" do
      skip
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
