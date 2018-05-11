require "test_helper"
require 'pry'

describe Movie do
  describe "relations" do
    it "movies has list of rentals" do
      movie_phantom = movies(:Phantom)
      movie_phantom.must_respond_to :rentals
    end
  end

  describe "validations" do
    let(:movie) { Movie.new() }

    it "can create a movie with title and release_date and inventory" do
      movie.title = "Lion King"
      movie.release_date = DateTime.now
      movie.inventory = 8
      movie.save
      is_valid = movie.valid?
      is_valid.must_equal true
    end

    it "must have both title and release_date" do
      movie.valid?.must_equal false
      movie.errors.messages.must_include :title
      movie.errors.messages.must_include :release_date
    end

    it "must have title" do
      movie.release_date = "Date.new-10"
      movie.valid?.must_equal false
      movie.errors.messages.must_include :title
    end

    it "must have release_date" do
      movie.title = "test_title"
      movie.valid?.must_equal false
      movie.errors.messages.must_include :release_date
    end
  end

  describe 'a_checkout' do
    it 'must reduce inventory by single value if current inventory > 0' do
      phantom_thread = movies(:Phantom)
      assert_operator phantom_thread.inventory, :>, 0
      proc{
          phantom_thread.a_checkout
      }.must_change 'phantom_thread.inventory', -1

    end

    it 'will return false on attempt to reduce stock on movies w/inventory of 0' do
      grease = movies(:Grease)
      grease.inventory.must_equal 0
      proc{
          grease.a_checkout
      }.wont_change 'grease.inventory'
      grease.a_checkout.must_equal false
    end
  end

  describe 'a_check_in' do
    it 'must increase inventory by 1' do
      phantom_thread = movies(:Phantom)
      proc{
          phantom_thread.a_check_in
      }.must_change 'phantom_thread.inventory', 1
    end

  end
end
