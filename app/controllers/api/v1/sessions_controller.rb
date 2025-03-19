module Api
  module V1
    class SessionsController < Api::V1::BaseController
      skip_before_action :authenticate_user!, only: [ :create ]
      # POST /api/v1/login
      def create
        user = User.find_by(email_address: params[:email_address])
        if user&.authenticate(params[:password])
          render json: { token: user.generate_jwt }, status: :ok
        else
          render json: { error: "Invalid email or password" }, status: :unauthorized
        end
      end
    end
  end
end
