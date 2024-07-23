class Tier < ApplicationRecord
  has_many :coaches

  validates :name,         presence: true, uniqueness: true, length: {minimum: 8, maximum: 30}
  validates :short_form,   presence: true, uniqueness: true, length: {minimum: 2, maximum: 5}
  validates :price_per_km, comparison: {greater_than: 0}
  
  default_scope -> { order(price_per_km: :desc) }

  # validate :minimum_price

  private

  # def minimum_price
  #   errors.add(:price_per_km, "must be greater than 0") unless price_per_km > 0
  # end
end