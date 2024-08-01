module V1
  module Helpers
    extend ::Grape::API::Helpers

    def current_user
      token           = headers['authorization']&.split(" ") || error!("Token must be present", 403)
      decode_token    = JwtToken.decode(token.last).first
      token_info      = HashWithIndifferentAccess.new(decode_token)
      @current_user ||= User.find_by(id: token_info[:user_id])
    rescue JWT::DecodeError, JWT::ExpiredSignature
      error!({ error: "Invalid token" }, 401)
    end
    
    def authenticate!
      error!({ error: "Failed authentication" }, 401) unless current_user
    end

  end
end
