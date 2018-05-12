class Customer < ApplicationRecord

  has_many :rentals
  has_many :movies, :through => :rentals

  validates :name, presence: true

  after_initialize :default_movie_count

  private
  def default_movie_count
    self.movies_checked_out_count ||= self.movies_checked_out_count = 0
  end
end
