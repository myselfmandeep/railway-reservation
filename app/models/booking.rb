class Booking < ApplicationRecord

  has_many   :tickets, dependent: :destroy
  belongs_to :schedule
  belongs_to :user
  belongs_to :payment

  accepts_nested_attributes_for :tickets
  
  default_scope -> { order(date: :desc) }
  
  scope :reserved_seats, -> (schedule, date, tier) {
    joins(tickets: { seat: :coach })
      .where(date: date, schedule: schedule)
      .where.not(tickets: { status: 'canceled' })
      .where(coaches: { tier: tier })
      .pluck('seats.id')
  }
  
  scope :available_seats, -> (schedule, date, tier) {
    class_seats = Train.total_class_seats(schedule.train, tier)
    taken_seats = reserved_seats(schedule, date, tier).count

    class_seats - taken_seats
  }

  validates :date, comparison: { greater_than: Date.today - 1.day }
  validates :pnr_number, uniqueness: true 
  
  validate :member_status, :past_booking
  
  private

  def member_status
    errors.add(:base, "You don't have a valid role") unless user.is_member?
  end

  def past_booking
    errors.add(:base, "You can't book for passed time") if Time.now.strftime("%H:%M") > schedule.arrived_at && date == Date.today
  end
  
end
