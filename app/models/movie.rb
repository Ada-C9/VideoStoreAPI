class Movie < ApplicationRecord
  has_many :rentals
  has_many :customers, :through => :rentals

  validates :title, presence: true

  after_initialize :default_inventory


  private
  def default_inventory
    
  end
end
