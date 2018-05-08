require "test_helper"

describe Customer do
  let(:customer) {Customer.create(name: "Tiya Linel")}

  describe "validations" do
    it 'requires a name' do
      customer[:name].wont_be_nil
      customer.valid?.must_equal true
    end
  end


    # it 'will not be valid with all nil values' do
    # end
  # end


  # describe "relations" do
  # end

end
