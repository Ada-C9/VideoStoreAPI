class Customer < ApplicationRecord

  has_and_belongs_to_many :movies
  has_many :rentals

  validates :name, presence: true
  validates :movies_checked_out_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_initialize do |customer|
      self.movies_checked_out_count ||= 0
  end

  def dec_checked_out_count

    self.movies_checked_out_count -= 1
  end

  def inc_checked_out_count

    self.movies_checked_out_count += 1
  end

end
