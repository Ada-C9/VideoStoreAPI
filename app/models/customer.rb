class Customer < ApplicationRecord
  has_many :rentals, dependent: :destroy

  validates_presence_of :name, :registered_at

  def as_json(options={})
    options[:methods] = [:movies_checked_out_count]
    super
  end

  def movies_checked_out_count
    movies_checked_out
  end

  private

  def movies_checked_out
    self.rentals.where(returned?: false).count
  end


end
