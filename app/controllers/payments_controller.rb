class PaymentsController < ApplicationController

  def new
    @payment = Payment.new(paid_amount: params[:amount])
  end
  
  def create
    @payment = Payment.new(payment_params)

    respond_to do |format|
      format.js
    end
  end

  def update
  end

  private

  def payment_params
    params.require(:payment).permit(:paid_amount).merge!({user: current_user, transaction_id: get_random_number(17)})
  end
  
end