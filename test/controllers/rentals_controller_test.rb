require "test_helper"


describe RentalsController do
  let(:mary) { customers(:mary) }
  let(:cherry) { customers(:cherry) }
  let(:one) { movies(:one) }
  let(:three) { movies(:three) }


  describe "Check Out" do
    it "can check-out a movie" do
      proc {
        post checkout_path params: {customer_id: mary.id, movie_id: one.id}
      }.must_change "Rental.count", 1

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "customer_id"
      body.must_include "movie_id"
      body.must_include "due_date"
    end

    it "increases checkout count" do
      start = mary.movies_checked_out_count
      post checkout_path params: {customer_id: mary.id, movie_id: one.id}
      mary.movies_checked_out_count.must_equal start + 1
    end

    it "decreases available inventory" do
      start = one.available_inventory
      post checkout_path params: {customer_id: mary.id, movie_id: one.id}
      one.reload
      one.available_inventory.must_equal start - 1
    end

    it "won't check-out a movie with bogus customer data" do
      proc {
        post checkout_path params: {customer_id: 0, movie_id: one.id }
      }.wont_change "Rental.count"

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
    end

    it "won't check-out a movie with bogus movie data" do
      one.destroy
      proc {
        post checkout_path params: {customer_id: mary.id, movie_id: movies(:one).id}
      }.wont_change "Rental.count"

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
    end

    it "won't create a rental if the available inventory is zero" do
      post checkout_path params:  {customer_id: mary.id, movie_id: movies(:two).id}

      post checkout_path params:  {customer_id: customers(:mary).id, movie_id: movies(:two).id}

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
    end

    it "won't change available inventory or customer checkout count if rental is bogus" do
      start = cherry.movies_checked_out_count
      one.destroy
      post checkout_path params: {customer_id: cherry.id, movie_id: movies(:one).id }
      cherry.reload
      cherry.movies_checked_out_count.must_equal start
    end
  end

  describe "Check In" do
    it "can check in a movie" do
      post checkin_path params:  {customer_id: mary.id, movie_id: movies(:one).id}

      must_respond_with :success

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "customer_id"
      body.must_include "movie_id"

    end

    it "won't check in a bad rental request" do
      one.destroy
      post checkin_path params:  {customer_id: mary.id, movie_id: movies(:one).id}

      must_respond_with :not_found

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
    end

    it "will update the customers checked out count" do
      start = mary.movies_checked_out_count

      post checkin_path params:  {customer_id: mary.id, movie_id: movies(:one).id}
      mary.movies_checked_out_count.must_equal start - 1
    end

    it "will update the movie's available_inventory" do
      start = one.available_inventory

      post checkin_path params:  {customer_id: mary.id, movie_id: movies(:one).id}
      one.reload
      one.available_inventory.must_equal start + 1
    end

    it "won't updated customers or movies if the rental is a bad request" do
      one.destroy
      post checkin_path params: {customer_id: customers(:mary).id, movie_id: movies(:one).id}
      must_respond_with :not_found

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
    end
  end
end
