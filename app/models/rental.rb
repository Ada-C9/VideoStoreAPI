class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  #https://stackoverflow.com/questions/29575259/default-values-for-models-in-rails

  after_initialize :set_defaults, unless: :persisted?

  private
  def set_defaults
    self.check_out_date ||= Date.today
    self.due_date ||= Date.today + 7
  end
end
