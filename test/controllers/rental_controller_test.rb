
require "test_helper"

describe RentalController do
  describe 'Checkout' do
  it 'a movie should get checked out' do
    proc{
      post check_out_url,
        params:{
          rental:{
                  customer_id: customers(:Linda).id,
                  movie_id: movies(:Phantom).id
                 }
              }
      }.must_change 'Rental.count',1
      JSON.parse(response.body).keys[0].must_equal "due_date"
      # binding.pry
      #
      # JSON.parse(response.body)["due_date"][-9].must_equal Rental.last.check_out.to_s[0..-8]
  end

  it 'will render error json for missing customer ID' do
    proc{
      post check_out_url,
        params:{
          rental:{
                  movie_id: movies(:Phantom).id
                 }
              }
      }.wont_change 'Rental.count'
    JSON.parse(response.body).keys.size.must_equal 2
    JSON.parse(response.body).keys[0].must_equal "ok"
    JSON.parse(response.body).keys[1].must_equal "error"

    JSON.parse(response.body)["ok"].must_equal false
    JSON.parse(response.body)["error"].must_equal "Enter an existing customer ID."

  end

  it 'will render error json for non-existant customer ID' do
    proc{
      post check_out_url,
        params:{
          rental:{
                  customer_id: nil,
                  movie_id: movies(:Phantom).id
                 }
              }
      }.wont_change 'Rental.count'
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
          rental:{
                  customer_id: customers(:Linda).id,
                  movie_id: nil
                 }
              }
      }.wont_change 'Rental.count'
    JSON.parse(response.body).keys.size.must_equal 2
    JSON.parse(response.body).keys[0].must_equal "ok"
    JSON.parse(response.body).keys[1].must_equal "error"

    JSON.parse(response.body)["ok"].must_equal false
    JSON.parse(response.body)["error"].must_equal "Enter an existing movie ID."
  end

  it 'will render error json for non-existant movie ID' do
    proc{
      post check_out_url,
        params:{
          rental:{
                  customer_id: customers(:Linda).id,
                  movie_id: nil
                 }
              }
      }.wont_change 'Rental.count'
    JSON.parse(response.body).keys.size.must_equal 2
    JSON.parse(response.body).keys[0].must_equal "ok"
    JSON.parse(response.body).keys[1].must_equal "error"

    JSON.parse(response.body)["ok"].must_equal false
    JSON.parse(response.body)["error"].must_equal "Enter an existing movie ID."
  end
  #
  # it 'will have a checkout date' do
  # end
  #
  # it 'will have a due_date' do
  # end
  #
  # it 'will render a json error when inventory is at 0' do
  # end
  #
  # it 'will only create a rental with valid params' do
  # end




end
  # it "should get check_in" do
  #   post check_out_path, params:{
  #     "customer_id": nil,
  #     "movie_id": movies(:Lion).id
  #   }
  #
  #   value(response).must_be :success?
  # end

  # it "should get check_out" do
  #   get rental_check_out_url
  #   value(response).must_be :success?
  # end

end
