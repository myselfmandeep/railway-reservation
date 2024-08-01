module V1
  module Entities
    class Seats < Base
      expose :number, :berth, :position
      
      expose :coach, using: Coaches
    end
  end
end
