class UsersController < ApplicationController
  skip_before_action :require_login, except: :show

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in(@user)
      redirect_to @user
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :first_name, :last_name,
    :password, :password_confirmation)
  end
end
