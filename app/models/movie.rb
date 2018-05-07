class Movie < ApplicationRecord
  has_many_and_belongs_to :rentals
end
