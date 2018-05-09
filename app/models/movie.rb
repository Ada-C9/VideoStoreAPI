class Movie < ApplicationRecord
  has_many :rentals
  has_many :customers, :through => :rentals

  validates :title, presence: true, uniqueness: true

  def available_to_rent?
    return self.available_inventory >= 1
  end


  def reduce_available_inventory
    self.available_inventory -= 1
    self.save
  end

  private
  #https://stackoverflow.com/questions/29575259/default-values-for-models-in-rails
  after_initialize :set_defaults, unless: :persisted?

  def set_defaults
    self.available_inventory ||= self.inventory
  end
end
