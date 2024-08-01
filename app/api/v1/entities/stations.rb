module V1
  module Entities
    class Stations < Base
      expose :name
      
      with_options(expose_nil: false) do
        expose :city
        expose :location
        expose :abbr
      end
    end
  end
end
