module SessionsHelper

  # To log in, store user_id in session hash
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns the current logged in user, if it exists.
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Returns true if user logged in, or false
  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

end
