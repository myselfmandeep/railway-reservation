module V1
  module Helpers
    module CommonParams
      extend ::Grape::API::Helpers

      params :searchable do
        requires :query, type: String, allow_blank: false
      end
      
    end
  end
end