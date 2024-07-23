class Seat < ApplicationRecord
  attr_accessor :new_seats

  def initialize(attributes={})
    @new_seats = []
    super(attributes)
  end

  BERTH         = %w[UB MB LB].freeze
  POSITION      = %w[window middle aisle].freeze
  WAITING_SEAT  = find_by(number: nil, berth: nil, position: nil).freeze

  has_many   :tickets
  belongs_to :coach

  validates :number, :berth, :position, presence: true
  
  validate :seat_no_greater_than_zero, :uniq_seat

  scope :get_available_seats, -> (schedule, date, slug, num_of_seats) {
    joins(:coach)
      .where(coach: { id: schedule.train.coaches, tier: slug })
      .where.not(id: Booking.reserved_seats(schedule, date, slug))
      .limit(num_of_seats)
      .pluck(:id)
  }

  private

  def uniq_seat
    # errors.add(:base, "Seat number #{number} already present for coach #{coach.name}") unless Seat.where(coach_id: coach_id, number: number).empty? 
    seat = Seat.find_by(coach_id: coach_id, number: number)
    errors.add(:base, "Seat number #{number} already present for coach #{coach.name}") if  seat.present? && seat != self
  end
  
  def seat_no_greater_than_zero
    errors.add(:base, "#{number} is invalid seat number #{coach.name}") unless number > 0
  end
  
end
