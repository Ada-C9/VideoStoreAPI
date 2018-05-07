require "test_helper"

describe Rental do
  
  describe "Relations " do

    it "relates movie, movie id, customer and customer id " do
      rental = Rental.create(
        customer: customers(:two),
        movie: movies(:one),
        due_date: Date.today + 21
      )

      rental.movie_id.must_equal movies(:one).id

      rental.customer_id.must_equal customers(:two).id
    end

  end
end
