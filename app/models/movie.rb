class Movie < ApplicationRecord

  validates :title, presence: true
  validates :inventory, :numericality => { :greater_than_or_equal_to => 0}

  def self.create_from_json(hash)
    hash["release_date"] = Date.parse(hash["release_date"])

    self.create!(hash)

  end
end
