# app/services/json_web_token.rb

class JsonWebToken
  # Use your application's secret key as the HMAC secret
  SECRET_KEY = Rails.application.credentials.secret_key_base.to_s

  # Encodes a payload with an expiration time into a JWT
  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i  # Set token expiration time
    JWT.encode(payload, SECRET_KEY)
  end

  # Decodes a JWT token back into the payload
  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new(decoded)
  rescue JWT::DecodeError
    nil
  end
end
