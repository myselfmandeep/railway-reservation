class Ticket < ApplicationRecord

  WAITING   = "waiting".freeze
  CONFIRMED = "confirmed".freeze
  CANCELED  = "canceled".freeze 
  STATES    = [WAITING, CONFIRMED, CANCELED].freeze
  
  belongs_to :booking
  belongs_to :seat
  has_one    :user,    through: :booking
  has_one    :payment, through: :booking

  validates :name, presence: true, length: {minimum: 3, maximum: 25 }
  validates :age,  presence: true, comparison: { greater_than: 0 }
  validates :gender, inclusion: {in: User::GENDER}
  validates :status, inclusion: {in: STATES}

  # validate :valid_age

  scope :waiting_tickets, -> { where(status: WAITING)}
  scope :canceled_tickets, -> { where(status: CANCELED)}

  private

  # def valid_age
  #   errors.add(:age, "must be greater than zero") if age <= 0
  # end
  
end
