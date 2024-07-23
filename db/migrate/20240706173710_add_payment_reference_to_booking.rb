class AddPaymentReferenceToBooking < ActiveRecord::Migration[7.1]
  def change
    add_reference :bookings, :payment, foreign_key: true, type: :uuid
    # add_reference :bookings, :payment, null: false, foreign_key: true
  end
end
