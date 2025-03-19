class User < ApplicationRecord
  has_secure_password
  has_many :cars, foreign_key: "user_id"
  has_many :sessions, dependent: :destroy
  has_many :maintenance_records, through: :cars

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def generate_jwt (exp = 24.hours.from_now)
    payload = { user_id: id, exp: exp.to_i }
    JWT.encode(payload, Rails.application.credentials.secret_key_base)
  end
end
