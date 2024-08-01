class BookingsController < ApplicationController
  before_action :set_booking, only: %i[update show]

  def index
    @bookings = policy.list
    # @bookings = policy.list.paginate(pagination)
  end

  def new
    @route    = Schedule.find(params[:schedule_id])
    @booking  = @route.bookings.new
    @seats    = params[:seats].to_i < 1 ? 1 : params[:seats].to_i
    # binding.pry
    # @amount   = Coach::PRICES[params["coach_class"]] * @seats * @route.distance
    @amount   = Tier.find(params["coach_class"]).price_per_km * @seats * @route.distance
    @payment  = Payment.new(paid_amount: @amount)

    @seats.times { @booking.tickets.build }
  end

  def create
    begin
      Booking.transaction do
        @booking       = Booking.new(booking_params)
        @booking.save!
        
        num_of_seats   = ticket_params.keys.length
        booking_class  = Tier.find(params[:booking][:coach_class])
        avail_seats    = Seat.get_available_seats(@booking.schedule, @booking.date, booking_class, num_of_seats)
        
        passengers     =  ticket_params.values.map do |passenger| 
          seat_id = avail_seats.shift
          status  = seat_id.nil? ? Ticket::WAITING : Ticket::CONFIRMED
          
          @booking.tickets.create!(permit_ticket(passenger).merge!({seat_id: seat_id, status: status}))
        end
      end
      
      redirect_to booking_ticket_path(@booking.id), notice: "successfully booked ticket for #{@booking.schedule.train.name}, which boarding on #{@booking.date}"
    rescue ActiveRecord::RecordInvalid => e
      redirect_to root_path, notice: e.record.errors.full_messages
    end

  end
  
  def show
    
  end

  def update
    if @booking.update(status: Booking::CANCELED)
      render json: { id: @booking.id }, status: :ok
    else
      render json: @booking.errors.full_messages, status: :forbidden
    end
  end

  # def destroy
  # end

  def check_availability
    @route    = Schedule.find(params[:schedule_id])
    @booking  = @route.bookings.new
    
    respond_to do |format|
      format.js
    end
  end

  private

  def booking_params
    params.require(:booking)
          .permit(:seats, :amount, :date, :schedule_id, :payment_id)
          .merge!({pnr_number: get_random_number(9), user: current_user})
  end

  def ticket_params
    params.require(:booking).require(:tickets_attributes)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def permit_ticket(ticket)
    ticket.permit(:name, :age, :gender)
  end

  def policy
    @policy ||= BookingPolicy.new(current_user)
  end

end