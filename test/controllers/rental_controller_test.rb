require "test_helper"

describe RentalController do
  describe "Check In" do
    it 'a movie should get checked in' do
      post check_in_url,
      params:{
        customer_id: customers(:Linda).id,
        movie_id: movies(:Phantom).id
      }


      Movie.find_by(id: movies(:Phantom).id).available_inventory.must_equal 13
      #No check out has occured yet (expect negative value)
      Customer.find_by(id: customers(:Linda).id).movies_checked_out_count.must_equal -1
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "status"
      body["status"].must_equal 200
    end

    it 'will render error json for missing customer ID field' do
      proc{
        post check_in_url,
        params:{
          movie_id: movies(:Phantom).id
        }
      }.wont_change 'Rental.count'
      Movie.find_by(id: movies(:Phantom).id).available_inventory.must_equal 12
      Customer.find_by(id: customers(:Linda).id).movies_checked_out_count.must_equal 0

      JSON.parse(response.body).keys.size.must_equal 2
      JSON.parse(response.body).keys[0].must_equal "ok"
      JSON.parse(response.body).keys[1].must_equal "errors"

      JSON.parse(response.body)["ok"].must_equal false
      JSON.parse(response.body)["errors"].must_equal "Invalid movie or customer"
    end

    it 'will render error json for non-existant customer ID' do
      proc{
        post check_in_url,
        params:{
          customer_id: nil,
          movie_id: movies(:Phantom).id
        }
      }.wont_change 'Rental.count'
      Movie.find_by(id: movies(:Phantom).id).available_inventory.must_equal 12
      Customer.find_by(id: customers(:Linda).id).movies_checked_out_count.must_equal 0

      JSON.parse(response.body).keys.size.must_equal 2
      JSON.parse(response.body).keys[0].must_equal "ok"
      JSON.parse(response.body).keys[1].must_equal "errors"

      JSON.parse(response.body)["ok"].must_equal false
      JSON.parse(response.body)["errors"].must_equal "Invalid movie or customer"
    end

    it 'will render error json for non-existant movie ID' do
      proc{
        post check_out_url,
        params:{
          customer_id: customers(:Linda).id,
          movie_id: nil
        }
      }.wont_change 'Rental.count'
      Movie.find_by(id: movies(:Phantom).id).available_inventory.must_equal 12
      Customer.find_by(id: customers(:Linda).id).movies_checked_out_count.must_equal 0

      JSON.parse(response.body).keys.size.must_equal 2
      JSON.parse(response.body).keys[0].must_equal "ok"
      JSON.parse(response.body).keys[1].must_equal "error"

      JSON.parse(response.body)["ok"].must_equal false
      JSON.parse(response.body)["error"].must_equal "Enter an existing movie ID."
    end
  end


  describe 'Checkout' do
    it 'is able to be checked out with valid params' do
      proc{
        post check_out_url,
        params:{
          customer_id: customers(:Linda).id,
          movie_id: movies(:Phantom).id
        }
      }.must_change 'Rental.count',1

      Movie.find_by(id: movies(:Phantom).id).available_inventory.must_equal 11
      Customer.find_by(id: customers(:Linda).id).movies_checked_out_count.must_equal 1
      Rental.last.customer_id.must_equal customers(:Linda).id

      JSON.parse(response.body).keys[0].must_equal "due_date"
      must_respond_with :success
    end

    it 'will render error json for missing customer ID' do
      proc{
        post check_out_url,
        params:{
          movie_id: movies(:Phantom).id
        }
      }.wont_change 'Rental.count'

      Movie.find_by(id: movies(:Phantom).id).available_inventory.must_equal 12
      Customer.find_by(id: customers(:Linda).id).movies_checked_out_count.must_equal 0

      JSON.parse(response.body).keys.size.must_equal 2
      JSON.parse(response.body).keys[0].must_equal "ok"
      JSON.parse(response.body).keys[1].must_equal "error"

      JSON.parse(response.body)["ok"].must_equal false
      JSON.parse(response.body)["error"].must_equal "Enter an existing customer ID."
    end

    it 'will render error json for missing movie ID' do
      proc{
        post check_out_url,
        params:{
          customer_id: customers(:Linda).id
        }
      }.wont_change 'Rental.count'

      Movie.find_by(id: movies(:Phantom).id).available_inventory.must_equal 12
      Customer.find_by(id: customers(:Linda).id).movies_checked_out_count.must_equal 0

      JSON.parse(response.body).keys.size.must_equal 2
      JSON.parse(response.body).keys[0].must_equal "ok"
      JSON.parse(response.body).keys[1].must_equal "error"

      JSON.parse(response.body)["ok"].must_equal false
      JSON.parse(response.body)["error"].must_equal "Enter an existing movie ID."

    end

    it 'will render error json for non-existant customer ID' do
      proc{
        post check_out_url,
        params:{
          customer_id: -1,
          movie_id: movies(:Phantom).id
        }
      }.wont_change 'Rental.count'

      Movie.find_by(id: movies(:Phantom).id).available_inventory.must_equal 12
      Customer.find_by(id: customers(:Linda).id).movies_checked_out_count.must_equal 0
      JSON.parse(response.body).keys.size.must_equal 2
      JSON.parse(response.body).keys[0].must_equal "ok"
      JSON.parse(response.body).keys[1].must_equal "error"

      JSON.parse(response.body)["ok"].must_equal false
      JSON.parse(response.body)["error"].must_equal "Enter an existing customer ID."
    end

    it 'will render error json for nil movie ID' do
      proc{
        post check_out_url,
        params:{
          customer_id: customers(:Linda).id,
          movie_id: nil
        }
      }.wont_change 'Rental.count'

      Movie.find_by(id: movies(:Phantom).id).available_inventory.must_equal 12
      Customer.find_by(id: customers(:Linda).id).movies_checked_out_count.must_equal 0
      JSON.parse(response.body).keys.size.must_equal 2
      JSON.parse(response.body).keys[0].must_equal "ok"
      JSON.parse(response.body).keys[1].must_equal "error"

      JSON.parse(response.body)["ok"].must_equal false
      JSON.parse(response.body)["error"].must_equal "Enter an existing movie ID."
    end

    it 'will render error json for nil movie ID' do
      proc{
        post check_out_url,
        params:{
          customer_id: customers(:Linda).id,
          movie_id: nil
        }
      }.wont_change 'Rental.count'

      Movie.find_by(id: movies(:Phantom).id).available_inventory.must_equal 12
      Customer.find_by(id: customers(:Linda).id).movies_checked_out_count.must_equal 0
      JSON.parse(response.body).keys.size.must_equal 2
      JSON.parse(response.body).keys[0].must_equal "ok"
      JSON.parse(response.body).keys[1].must_equal "error"

      JSON.parse(response.body)["ok"].must_equal false
      JSON.parse(response.body)["error"].must_equal "Enter an existing movie ID."
    end


    it 'will render a json error when available inventory is at 0' do
      proc{
        post check_out_url,
        params:{
          customer_id: customers(:Linda).id,
          movie_id: movies(:Grease).id
        }
      }.wont_change 'Rental.count'

      Movie.find_by(id: movies(:Grease).id).available_inventory.must_equal 0
      Movie.find_by(id: movies(:Grease).id).inventory.must_equal 12

      Customer.find_by(id: customers(:Linda).id).movies_checked_out_count.must_equal 0
      JSON.parse(response.body)["ok"].must_equal false
      JSON.parse(response.body)["error"].must_equal "Movie requested is currently out of stock."
    end

    it 'will only create a rental with valid non-nil params' do
      proc{
        post check_out_url,
        params:{
          customer_id: -1,
          movie_id: -1
        }
      }.wont_change 'Rental.count'
      Movie.find_by(id: movies(:Phantom).id).available_inventory.must_equal 12
      Customer.find_by(id: customers(:Linda).id).movies_checked_out_count.must_equal 0
      JSON.parse(response.body)["ok"].must_equal false
      JSON.parse(response.body)["error"].must_equal "Enter an existing customer ID and movie ID."
    end
  end
end
