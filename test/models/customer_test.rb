require "test_helper"

describe Customer do
  let(:jane) {customers(:jane)}
  let(:ava) {customers(:ava)}

  it "must have a name to be valid" do
    jane.name = nil
    jane.valid?.must_equal false
  end

  describe 'relations' do
    it 'checks that a customer already exists' do
      ava = customers(:ava)
      value(ava).must_be :valid?
    end

  end
end
