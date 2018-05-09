class Movie < ApplicationRecord
  has_many :rentals
  has_many :customers, :through => :rentals

  validates :title, presence: true, uniqueness: true

  #https://stackoverflow.com/questions/29575259/default-values-for-models-in-rails

  private
  after_initialize :set_defaults, unless: :persisted?

  def set_defaults
    self.available_inventory ||= self.inventory
  end
end
