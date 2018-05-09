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

      binding.pry

      rental_data = {
        customer_id: (customers(:one)).id,
        movie_id: (movies(:one)).id,
        check_out_date: Date.today.to_s,
        due_date: (Date.today + 7).to_s
      }

      rental = Rental.new(rental_data)

      rental.save

      rental.valid?.must_equal true
    end

    it "must have check_out_date" do

      rental_data = {
        customer_id: (customers(:one)).id,
        movie_id: (movies(:one)).id,
        check_out_date: nil,
        due_date: (Date.today + 7).to_s
      }

      rental = Rental.create(rental_data)

      rental.valid?.must_equal false
    end

    it "must have movie_id" do

      rental_data = {
        customer_id: (customers(:one)).id,
        movie_id: nil,
        check_out_date: Date.today.to_s,
        due_date: (Date.today + 7).to_s
      }

      rental = Rental.create(rental_data)

      rental.valid?.must_equal false
    end

    it "must have customer_id" do

      rental_data = {
        customer_id: nil,
        movie_id: (movies(:one)).id,
        check_out_date: Date.today.to_s,
        due_date: (Date.today + 7).to_s
      }

      rental = Rental.create(rental_data)

      rental.valid?.must_equal false
    end

    it "must have due_date" do

      rental_data = {
        customer_id: (customers(:one)).id,
        movie_id: (movies(:one)).id,
        check_out_date: Date.today.to_s,
        due_date: nil
      }

      rental = Rental.create(rental_data)

      rental.valid?.must_equal false
    end
  end

end
