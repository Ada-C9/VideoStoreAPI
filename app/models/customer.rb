class Customer < ApplicationRecord
  validates :name, presence: true
  validates :phone, presence: true
  validates :phone, length: { is: 10 }
end
