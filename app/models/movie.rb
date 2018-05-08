class Movie < ApplicationRecord
  has_many :rentals
  has_many :customers, :through => :rentals

  validates :title, presence: true

  def available_inventory 
  end
end
