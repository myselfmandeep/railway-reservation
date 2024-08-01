module V1
  module Auth
    class Base < Grape::API
      
      mount Sessions
      
    end
    
  end
end
