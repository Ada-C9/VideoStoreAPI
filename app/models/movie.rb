class Movie < ApplicationRecord

  validates :title, :overview, :release_date, :inventory, presence: true

  validates :inventory, numericality: { greater_than: 0 }


end
