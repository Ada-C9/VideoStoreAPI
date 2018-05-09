require "test_helper"

describe Rental do
  describe "valid" do
    before do
      rental = rentals(:one)
      rental.check_out_date = Date.today.to_s
      rental.due_date = (Date.today + 7).to_s
      rental.save
    end

    it "is a valid rental" do
      rentals(:one).valid?.must_equal true
    end

    it "must have customer_id" do
      rentals(:one).customer_id = nil
      rentals(:one).valid?.must_equal false
    end

    it "must have movie_id" do
      rentals(:one).movie_id = nil
      rentals(:one).valid?.must_equal false
    end

    it "must have numerical customer_id" do
      rentals(:one).customer_id = "cat"
      rentals(:one).valid?.must_equal false
    end

    it "must have numerical movie_id" do
      rentals(:one).customer_id = "dog"
      rentals(:one).valid?.must_equal false
    end

    it "must have check_out_date" do
      rentals(:one).check_out_date = nil
      rentals(:one).valid?.must_equal false
    end

    it "must have due_date" do
      rentals(:one).due_date = nil
      rentals(:one).valid?.must_equal false
    end
  end

  describe "relations" do
    before do
      rental = rentals(:one)
      rental.check_out_date = Date.today.to_s
      rental.due_date = (Date.today + 7).to_s
      rental.save
    end
    
    it "must respond to movie" do
      rental = rentals(:one)
      rental.movie.must_equal movies(:one)
    end

    it "must respond to cusomer" do
      rental = rentals(:one)
      rental.customer.must_equal customers(:one)
    end
  end




  # describe "Valid?" do
  #   it "must be valid" do
  #
  #     rental_data = {
  #       customer_id: (customers(:one)).id,
  #       movie_id: (movies(:one)).id,
  #       check_out_date: Date.today.to_s,
  #       due_date: (Date.today + 7).to_s
  #     }
  #
  #     rental = Rental.new(rental_data)
  #
  #     rental.save
  #
  #     rental.valid?.must_equal true
  #   end
  #
  #   it "must have check_out_date" do
  #
  #     rental_data = {
  #       customer_id: (customers(:one)).id,
  #       movie_id: (movies(:one)).id,
  #       check_out_date: nil,
  #       due_date: (Date.today + 7).to_s
  #     }
  #
  #     rental = Rental.create(rental_data)
  #
  #     rental.valid?.must_equal false
  #   end
  #
  #   it "must have movie_id" do
  #
  #     rental_data = {
  #       customer_id: (customers(:one)).id,
  #       movie_id: nil,
  #       check_out_date: Date.today.to_s,
  #       due_date: (Date.today + 7).to_s
  #     }
  #
  #     rental = Rental.create(rental_data)
  #
  #     rental.valid?.must_equal false
  #   end
  #
  #   it "must have customer_id" do
  #
  #     rental_data = {
  #       customer_id: nil,
  #       movie_id: (movies(:one)).id,
  #       check_out_date: Date.today.to_s,
  #       due_date: (Date.today + 7).to_s
  #     }
  #
  #     rental = Rental.create(rental_data)
  #
  #     rental.valid?.must_equal false
  #   end
  #
  #   it "must have due_date" do
  #
  #     rental_data = {
  #       customer_id: (customers(:one)).id,
  #       movie_id: (movies(:one)).id,
  #       check_out_date: Date.today.to_s,
  #       due_date: nil
  #     }
  #
  #     rental = Rental.create(rental_data)
  #
  #     rental.valid?.must_equal false
  #   end
  # end

end
