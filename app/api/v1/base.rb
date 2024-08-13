
module V1
  class Base < Grape::API
    VERSION = "v1"
    format :json
    
    helpers V1::Helpers::GeneralHelpers
    
    before do
      unless request.request_method == "POST" && request.path == "/api/v1/auth/session"
        authenticate!
      end
    end
    
    mount V1::Auth::Base => "/auth"
    mount V1::Admin::Base => "/admin"
    mount Users
    mount Bookings
    mount Chats
    mount Messages
    
    desc "handle record not found"
    rescue_from ActiveRecord::RecordNotFound do
      error! "Record not found", 404
    end
    
    desc "Handle Invalid Paths"
    route :any, "*path" do
      error! "Route is not found", 404
    end
    
    add_swagger_documentation
  end
end
