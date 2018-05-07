require "test_helper"

describe Movie do
  describe "validations" do
    # all validations pass
    before do
      # Arrange


      @movie = Movie.new(
        title: "test movie",
        overview: "The unexciting life of a boy",
        release_date: "1979-01-18",
        inventory: "10"
      )
      end

      it "can be created will all required fields" do
        # Act
        result = @movie.valid?

        # Assert
        result.must_equal true


      end

      # no title -> fail
      it "is invalid without a title" do
        @movie.title = nil

        result = @movie.valid?

        result.must_equal false
        @movie.errors.messages.must_include :title
      end

      # duplicate title -> fail
      it "is invalid with a duplicate title" do
        dup_movie = Movie.first
        @movie.title = dup_movie.title

        result = @movie.valid?

        result.must_equal false
        @movie.errors.messages.must_include :title
      end
    end

  end
