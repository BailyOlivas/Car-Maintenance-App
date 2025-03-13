class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
  end

  def create
    user = User.find_by(email_address: session_params[:email_address])
    if user&.authenticate(session_params[:password])
      start_new_session_for user
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      redirect_to new_session_path, alert: "Try another email address or password."
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path
  end
end

private


def session_params
  params.permit(:email_address, :password, :authenticity_token, :commit)
end
