class Movie < ApplicationRecord
  has_and_belongs_to_many :rentals
end
