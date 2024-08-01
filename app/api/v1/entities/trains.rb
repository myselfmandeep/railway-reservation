module V1
  module Entities
    class Trains < Base
      expose :name, :uniq_number, :working_days, :category
      
      expose :coaches, with: Coaches
    end
  end
end
