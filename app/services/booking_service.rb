

class BookingService < ApplicationService
  attr_reader :booking_params, :ticket_params, :user, :tier

  def initialize(params, user)
    @user           = user.id
    @booking_params = params[:bookings]
    @ticket_params  = params[:tickets]
    @tier           = params[:tier]
  end

  def call
    Booking.transaction do
      
      booking = Booking.new(booking_params.merge!({user_id: user}))
      booking.save!

      
      avail_seats = Seat.get_available_seats(booking.schedule, booking.date, tier, ticket_params.count)
      tickets     = ticket_params.map do |passenger|
        seat_id = avail_seats.shift
        status  = seat_id.nil? ? Ticket::WAITING : Ticket::CONFIRMED
        
        booking.tickets.create!(passenger.merge!({seat_id: seat_id, status: status}))
      end

      return booking
    rescue => e
      false
    end
  end

end
