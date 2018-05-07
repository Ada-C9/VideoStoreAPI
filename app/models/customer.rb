class Customer < ApplicationRecord
  has_many :rentals, dependent: :destroy

  validates_presence_of :name, :registered_at
end
