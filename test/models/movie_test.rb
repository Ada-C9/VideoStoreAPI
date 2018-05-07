require "test_helper"

describe Movie do
  describe 'validations' do
    it 'must have a title' do
      movie = Movie.new(
        title: nil,
        inventory: 2
      )

      movie.valid?.must_equal false
      movie.errors.messages.must_include :title
    end

    it 'must have an inventory as an integer greater than 0' do
      movie = Movie.new(
        title: 'A movie title',
        inventory: nil
      )

      movie2 = Movie.new(
        title: 'Another title',
        inventory: -1
      )

      movie.valid?.must_equal false
      movie.errors.messages.must_include :inventory
      movie2.valid?.must_equal false
      movie2.errors.messages.must_include :inventory
    end

    it 'will not allow a movie with the same title and same release_date' do
      movie = Movie.create!(
        title: 'A movie title',
        inventory: 1,
        release_date: Date.new(2018,04,02)
      )

      movie2 = Movie.new(
        title: movie.title,
        inventory: 1,
        release_date: movie.release_date
      )

      movie2.valid?.must_equal false
      movie2.errors.messages.must_include :release_date
    end
  end
end
