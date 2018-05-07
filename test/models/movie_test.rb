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

end
