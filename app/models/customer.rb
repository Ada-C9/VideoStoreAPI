class Customer < ApplicationRecord
  has_many :rentals
  has_many :movies, :through => :rentals

  validates :name, presence: true

  #https://stackoverflow.com/questions/29575259/default-values-for-models-in-rails

  after_initialize :set_defaults, unless: :persisted?

  def increase_movies_checked_out_count
    self.movies_checked_out_count += 1
    self.save
  end

  def decrease_movies_checked_out_count
    self.movies_checked_out_count -= 1
    self.save
  end


  private
  def set_defaults
    self.movies_checked_out_count ||= 0
  end
end
