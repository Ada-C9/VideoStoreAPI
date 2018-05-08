class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie
  alias_attribute :created_at, :check_out_date

  validates :movie_id, presence: true
  validates :customer_id, presence: true

  validate :has_enough_inventory?, if: :movie_id?

  def movie_id?
    return self.movie_id
  end

  def has_enough_inventory?
    unless self.movie.inventory > 0
      errors[:quantity] << 'Not enough inventory for this rental'
    end
  end
end
