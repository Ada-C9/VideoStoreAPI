class Customer < ApplicationRecord

  validates :name, :address, :city, :state, :postal_code, :phone, presence: true

  validates :postal_code, length: { is: 5 }

  validates :phone, length: { is: 10 }


end
