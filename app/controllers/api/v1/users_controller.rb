module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :verify_authenticity_token
      skip_before_action :require_authentication, only: [ :create ]

      # POST /api/v1/users
      def create
        user = User.new(user_params)
        if user.save
          token = JsonWebToken.encode(user_id: user.id)
          render json: { token: token, user: user }, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:name, :email_address, :password)
      end
    end
  end
end
