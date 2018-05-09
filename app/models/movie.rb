class Movie < ApplicationRecord

  has_many :rentals

  validates :title, :inventory, :available_inventory, presence: true

  validates :inventory, numericality: {only_integer: true, greater_than: 0}

  validates :available_inventory, numericality: { only_integer: true, greater_than: 0}

  validate :available_inventory_cannot_exceed_inventory

  def available_inventory_cannot_exceed_inventory
    if inventory
      if inventory < available_inventory
      errors.add(:available_inventory, "Cannot exceed inventory")
      end
    end
  end

  def self.decrement(movie)

    if movie && movie.available_inventory > 0
      movie.available_inventory -= 1
    else
      # figure out how we will process invalid requests
    end
  end

end
