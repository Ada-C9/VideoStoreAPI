class Customer < ApplicationRecord
  validates :name, :phone, presence: true
end
