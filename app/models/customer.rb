class Customer < ApplicationRecord
  validates :name, :phone, presence: true
  has_many :rentals
end
