class Movie < ApplicationRecord
   validates :title, presence: true
   has_many :rentals
   has_many :customers, through: :rentals

end
