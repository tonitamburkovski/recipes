module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def logged_in?
    @current_user.present?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def session_notice
    flash[type] = message
    redirect_to root_path && return
  end

  def equal_with_current_user?(other_user)
    current_user == other_user
  end
end
