class Customer < ApplicationRecord
  validates :name, :phone, presence: true
  has_many :rentals

  def add_movie
    self.movies_checked_out_count += 1
    self.save
  end

  def remove_movie
    self.movies_checked_out_count -= 1
    self.save
  end
end
