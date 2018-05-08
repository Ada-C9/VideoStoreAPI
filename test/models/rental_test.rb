require "test_helper"

describe Rental do
  describe "Valid?" do
    # it "must create valid rental with  valid data" do
    #   params = {
    #     customer_id: customers(:one).id,
    #     movie_id: movies(:two).id,
    #   }
    #
    #   # rental_data = {
    #   #   customer_id: params[:customer_id],
    #   #   movie_id: params[:movie_id],
    #   #   check_out_date: Date.today.to_s,
    #   #   due_date: (Date.today + 7).to_s
    #   # }
    #
    #   rental = Rental.create(params)
    #   binding.pry
    #
    #   rental.valid?.must_equal true
    # end

    it "must be valid" do
      rental = rentals(:one)

      date = Date.today
      rental.check_in_date = date
      rental.due_date = Date.today + 7
      rental.save

      rental.valid?.must_equal true
    end
    #
    # it "must have check_out_date" do
    #   params = {
    #     customer_id: customers(:one).id,
    #     movie_id: movies(:two).id
    #   }
    #
    #   rental = Rental.create(params)
    #
    #   rental.valid?.must_equal true
    # end
  end

end
