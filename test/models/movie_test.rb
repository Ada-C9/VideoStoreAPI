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
      result = Movie.create_from_request(hash)
      result.must_be_kind_of Movie
      result.title.must_equal hash["title"]
      Movie.count.must_equal old_count + 1
    end

    it "doesn't create an instance with incomplete data" do
      hash = {
         "overview": "The unexciting life of a boy will be permanently altered as a strange woman enters his life.",
         "release_date": "1979-01-18",
         "inventory": 10
      }

      old_count = Movie.count
      proc {
        Movie.create_from_request(hash)
      }.must_raise

      Movie.count.must_equal old_count
    end

    it "doesn't create an instance with unacceptable data" do
      hash = {
        "title": "Some Title",
         "overview": "The unexciting life of a boy will be permanently altered as a strange woman enters his life.",
         "release_date": "1979-01-18",
         "inventory": -7
      }

      old_count = Movie.count
      proc {
        Movie.create_from_request(hash)
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

  describe "Movie.request_query" do

    it "takes in a hash and returns a collection of movies" do
      params_hash = {
        "sort": "title",
        "p": "2",
        "n": "5"
      }
      expected_length = 5
      sorted_movies = Movie.all.order(:title)

      result = Movie.request_query(params_hash, Movie)
      result.must_be_kind_of Array
      result.each do |movie|
        movie.must_be_kind_of Movie
      end
      result.length.must_equal expected_length
      names = result.map { |movie| movie.title }
      names.sort.must_equal names
      result.must_equal sorted_movies[5..9]
    end

    it "works if params hash empty" do
      params_hash = {}

      result = Movie.request_query(params_hash, Movie)
      result.must_be_kind_of Array
      result.each do |movie|
        movie.must_be_kind_of Movie
      end
      result.length.must_equal Movie.count
    end

    it "work if only one optional" do
      params_hash = {
        "p": "2",
      }

      result = Movie.request_query(params_hash, Movie)
      result.must_be_kind_of Array
      result.each do |movie|
        movie.must_be_kind_of Movie
      end
      result.length.must_equal 3
    end

    it "works if two optionals" do
      params_hash = {
        "p": "4",
        "n": "3"
      }

      result = Movie.request_query(params_hash, Movie)
      result.must_be_kind_of Array
      result.each do |movie|
        movie.must_be_kind_of Movie
      end
      result.length.must_equal 3
    end

    it "works if all random incorrect params" do
      params_hash = {
        "sort": "somethingelse",
        "kitties"=> "something",
        "banana"=> "5",
        "n"=> "bananas"
      }

      result = Movie.request_query(params_hash, Movie)
      result.must_be_kind_of Array
      result.each do |movie|
        movie.must_be_kind_of Movie
      end
      result.length.must_equal Movie.count
    end



  end

end
