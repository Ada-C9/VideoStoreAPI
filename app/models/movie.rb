class Movie < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :inventory, presence: true
end
