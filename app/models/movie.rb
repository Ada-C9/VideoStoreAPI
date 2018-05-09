class Movie < ApplicationRecord
  has_many :rentals, dependent: :destroy

  validates :title, presence: true
  validates :inventory, presence: true, numericality: true

  def as_json(options={})
    options[:methods] = [:available_inventory]
    super
  end

  def available_inventory
    calc_inventory
  end

  private

  def calc_inventory
    checked_out = self.rentals.where(returned?: false).count
    return self.inventory - checked_out
  end


end
