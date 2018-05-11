class Customer < ApplicationRecord
  has_many :rentals
  has_many :movies, through: :rentals

  validates :name, presence: true
  validates :movies_checked_out_count, presence: true, numericality: { only_integer: true }

  def decrement_movies_checked_out_count
    if self.movies_checked_out_count > 0
      self.movies_checked_out_count -= 1
    end
  end

  def increment_movies_checked_out_count
      self.movies_checked_out_count += 1
  end

end
