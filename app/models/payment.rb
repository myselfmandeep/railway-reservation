class Payment < ApplicationRecord

  has_one    :booking
  belongs_to :user
  # belongs_to :booking

  validates :paid_amount, presence: true
  
  before_update :check_refund

  def check_refund
    errors.add(:refund_amount, "must be present") unless refund_amount.present?
  end
  
end