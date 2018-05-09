require "test_helper"

describe RentalController do
  describe 'Checkout' do
  it 'a movie should get checked out' do
    
  end

  it 'will render error json for missing customer ID' do
  end

  it 'will render error json for non-existant customer ID' do
  end

  it 'will render error json for missing movie ID' do
  end

  it 'will render error json for non-existant movie ID' do
  end

  it 'will have a checkout date' do
  end

  it 'will have a due_date' do
  end

  it 'will render a json error when inventory is at 0' do
  end

  it 'will only create a rental with valid params' do
  end




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
