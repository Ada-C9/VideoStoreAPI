require "test_helper"

describe RentalsController do
  describe 'checkout' do

    it 'returns a json object' do
      customer_id = customers(:kari).id
      post new_rental_path("Robots Of Eternity"), params: { rental: {customer_id: customer_id } }
      response.header['Content-Type'].must_include 'json'
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include 'id'

      Rental.find(body['id']).customer_id.must_equal customer_id
    end



    it 'creates a new rental' do
      proc {
        post new_rental_path("Robots Of Eternity"), params: { rental: { customer_id: 1 } }
      }.must_change 'Rental.count', 1
      must_respond_with :success
    end

    it 'does not create a rental with invalid input'  do

      proc {
        post new_rental_path("Robots Of Eternity"), params: { rental: { customer_id: -4 } }
      }.wont_change 'Rental.count'
      must_respond_with :bad_request

    end

    it "has the correct movie, customer, checkout date, due date (a week away), checkout status of true" do
      movie_title = "Robots Of Eternity"
      customer_id = customers(:kari).id

      post new_rental_path(movie_title), params: { rental: { customer_id: customer_id } }
      rental = Rental.last
      rental.movie.title.must_equal movie_title
      rental.customer_id.must_equal customer_id
      rental.checkout_date.must_equal "2018-05-09"
      rental.due_date.must_equal "2018-05-16"
      rental.checked_out.must_equal true
    end

    it "changes the movie model's available_inventory when the movie is rented" do
      post new_rental_path("Robots Of Eternity"), params: { rental: { customer_id: 1 } }
      Rental.last.movie.available_inventory.must_equal 4
    end

    it "increases a customers movie count" do
      post new_rental_path("Robots Of Eternity"), params: { rental: { customer_id: 1 } }
      Rental.last.customer.movies_checked_out_count.must_equal 2
    end

  end


  describe 'checkin' do
    before do
      post new_rental_path("Robots Of Eternity"), params: { rental: { customer_id: 1 } }
    end
    it 'finds the correct rental to checkin' do
      skip
      post return_rental_path("Robots Of Eternity"), params: { rental: { customer_id: 1} }
      rental = Rental.last
      rental.customer_id.must_equal 1
      rental.movie.title.must_equal "Robots Of Eternity"

    end

    it 'renders an error if rental was not found' do
      proc {
        post return_rental_path("Robots Of Eternity"), params: { rental: { customer_id: -4 } }
      }.wont_change 'Rental.count'

      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body.must_equal "errors" =>  "No rental with id #{params[:id]}"
    end

    it "if bad request, responds with bad request" do
        proc {
            post return_rental_path("Robots Of Eternity"), params: { rental: { customer_id: -4 } }
        }.wont_change 'Rental.count'

        must_respond_with :bad_request
        body = JSON.parse(response.body)
        body.must_equal "errors" =>  "could not find rental"
    end

    it "responds with success and doesn't change the rental count" do
      proc {
        post return_rental_path("Robots Of Eternity"), params: { rental: { customer_id: 1 } }
      }.wont_change 'Rental.count'
      must_respond_with :success
    end

    it "changes rental status" do
       post return_rental_path("Robots Of Eternity"), params: { rental: { customer_id: 1} }
       movie_id = movies(:robots).id
       customer_id = customers(:kari).id
       rental = Rental.find_by_movie_id_and_customer_id(movie_id, customer_id)
       rental.checked_out.must_equal false
   end

   it "changes available_inventory" do
        post return_rental_path("Robots Of Eternity"), params: { rental: { customer_id: 1 } }
        Rental.last.movie.available_inventory.must_equal 50
    end

  end
end
