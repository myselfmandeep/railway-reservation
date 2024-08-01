module V1
  module Entities
    class Schedules < Base
      expose :arrived_at,   as: :starts_at 
      expose :departure_at, as: :end_at
      
      expose :source_station, :destination_station, with: Stations
      expose :train,                                with: Trains
    end
  end
end
