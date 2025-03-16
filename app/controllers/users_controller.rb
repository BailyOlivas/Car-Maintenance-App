class UsersController < ApplicationController
  skip_before_action :require_authentication, only: [ :new, :create ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      start_new_session_for @user
      redirect_to dashboard_path
    else
      render :new
    end
  end
end


private

def user_params
  params.require(:user).permit(:name, :email_address, :password)
end
