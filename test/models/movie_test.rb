require "test_helper"

describe Movie do

  describe "create from json" do

    it "creates an instance from complete hash" do
      hash = {
         "title" => "Blacksmith Of The Banished",
         "overview" => "The unexciting life of a boy will be permanently altered as a strange woman enters his life.",
         "release_date" => "1979-01-18",
         "inventory" => 10
      }

      old_count = Movie.count
      result = Movie.create_from_json(hash)
      result.must_be_kind_of Movie
      result.title.must_equal hash["title"]
      Movie.count.must_equal old_count + 1
    end

    it "doesn't create an instance with incomplete data" do
      hash = {
         "overview" => "The unexciting life of a boy will be permanently altered as a strange woman enters his life.",
         "release_date" => "1979-01-18",
         "inventory" => 10
      }

      old_count = Movie.count
      proc {
        Movie.create_from_json(hash)
      }.must_raise

      Movie.count.must_equal old_count
    end

    it "doesn't create an instance with unacceptable data" do
      hash = {
        "title" => "Some Title",
         "overview" => "The unexciting life of a boy will be permanently altered as a strange woman enters his life.",
         "release_date" => "1979-01-18",
         "inventory" => -7
      }

      old_count = Movie.count
      proc {
        Movie.create_from_json(hash)
      }.must_raise

      Movie.count.must_equal old_count
    end

  end

  describe "#available" do
    before do
      @movie = Movie.first
      @customer = Customer.first
    end
    it "returns an integer of available inventory" do
      result = @movie.available
      result.must_be_kind_of Integer
    end

    it "updates when checkout and checkin" do
      original_avail = @movie.available

      rental = Rental.create_from_request(movie_id: @movie.id, customer_id: @customer.id)
      rental.save

      result = @movie.available
      result.must_equal original_avail - 1

      rental.checkin_date = DateTime.now
      rental.save

      new_result = @movie.available
      new_result.must_equal original_avail
    end

  end

end
