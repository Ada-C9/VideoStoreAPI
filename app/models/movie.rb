class Movie < ApplicationRecord
  has_and_belongs_to_many :customers

  validates :title, presence: true
  
end
