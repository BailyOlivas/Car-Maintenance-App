module Api
  module V1
    class BaseController < ActionController::API
      before_action :authenticate_user!

      private

      def current_user
        header = request.headers["Authorization"]
        token = header.split(" ").last if header.present?
        return nil unless token

        decoded = JsonWebToken.decode(token)
        # Use the string key "user_id" rather than :user_id
        User.find_by(id: decoded["user_id"])
      rescue JWT::DecodeError, ActiveRecord::RecordNotFound
        nil
      end

      def authenticate_user!
        token = request.headers["Authorization"]
        return render json: { error: "Unauthorized" }, status: :unauthorized if token.blank?

        decoded_token = JsonWebToken.decode(token.split(" ").last)
        @current_user = User.find_by(id: decoded_token[:user_id]) if decoded_token

        render json: { error: "Unauthorized" }, status: :unauthorized unless @current_user
      end
    end
  end
end
