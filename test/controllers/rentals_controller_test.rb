require "test_helper"
require 'pry'

describe "RentalsController" do

  it "can create new rental" do

    rental_count = Rental.all.count

    customer_movie_info = {
      customer_id: customers(:one).id,
      movie_id: movies(:one).id
    }

    post rental_path(customer_movie_info)

    Rental.all.count.must_equal (rental_count + 1)
  end

    it "should be able update a rental" do

    end

  end
