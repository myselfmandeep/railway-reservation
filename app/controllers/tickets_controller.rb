class TicketsController < ApplicationController
  def show
    @booking   = Booking.find(params[:booking_id])
    @route     = @booking.schedule
    @train     = @route.train
    @tickets   = @booking.tickets
    @adults    = @tickets.pluck(:age).group_by {|age| age > 18}
  end

  def create
    # 
  end

  def destroy
    @ticket       = Ticket.find(params[:ticket_id])
    @payment      = @ticket.payment
    @siblings     = @ticket.booking.tickets.count
    @amount       = @ticket.payment.paid_amount
    # @amount       = @ticket.booking.amount
    @ticket_price = @amount / (100 / (1.0 / @siblings.to_f * 100))
    @prev_refund  = (@ticket.payment.refund_amount || 0)

    if @payment.update(refund_amount: (@prev_refund+@ticket_price))
      @ticket.update(status: Ticket::CANCELED)
    end
    
    respond_to do |format|
      format.js
    end
  end
  
end