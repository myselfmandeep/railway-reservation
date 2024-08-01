
module V1
  module Entities
    class Bookings < Base
      expose :amount, :date, :pnr_number
      expose :schedule, with: Schedules
      expose :tickets,  with: Tickets
      expose :payment,  with: Payments, expose_nil: false
    end
  end
end
