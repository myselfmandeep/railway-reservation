module JwtToken
  class << self

    def encode(payload, algo="HS256")
      time_now = Time.now.to_i
      details = {
                  uniq: SecureRandom.uuid,
                  iat: time_now,
                  exp: time_now + 15 * 60
                }
                
      payload.merge!(details)

      JWT.encode(payload, secret_key, algo)
    end
    
    def decode(token, algo="HS256")
      JWT.decode(token, secret_key, true, {algorithm: algo})
    end

    private
    
    def secret_key
      @@secret_key ||= Rails.configuration.secret_key_base
    end
  end

end
