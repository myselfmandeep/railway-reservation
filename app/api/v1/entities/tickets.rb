module V1
  module Entities
    class Tickets < Base
      expose :name, :age, :gender, :status
      
      expose :seat, with: Seats
    end
  end
end
