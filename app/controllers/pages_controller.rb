class PagesController < ApplicationController
  allow_unauthenticated_access only: :home

  def home
    redirect_to dashboard_path if authenticated?
  end

  def dashboard
    @cars = current_user.cars
    redirect_to new_session_path unless authenticated?
  end
end
