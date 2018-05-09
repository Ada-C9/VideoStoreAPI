class Customer < ApplicationRecord
  has_many :rentals
  has_many :movies, :through => :rentals

  validates :name, presence: true

  #https://stackoverflow.com/questions/29575259/default-values-for-models-in-rails

  after_initialize :set_defaults, unless: :persisted?

  private
  def set_defaults
    self.movies_checked_out_count ||= 0
  end
end
