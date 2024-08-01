module V1
  module Entities
    class Coaches < Base
      expose :name, :description
      
      expose :tier, with: Tiers
    end
  end
end
