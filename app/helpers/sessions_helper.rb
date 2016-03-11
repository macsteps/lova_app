module SessionsHelper

  # To log in, store user_id in session hash
  def log_in(user)
    session[:user_id] = user.id
  end

  # Remember a user in a persistent session.
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent.signed[:remember_token] = user.remember_token
  end

  # Returns the current logged in user, if it exists.
  def current_user
    if (user_id = session[:user_id]) # the browser session is active
      @current_user ||= User.find_by(id: session[:user_id])
    elsif (user_id = cookies.signed[:user_id]) # the cookie (aka remember) is active.
      user = User.find_by(id: user_id)
      if user && authenticated?(cookies[:remember_token]) # user is not logged in (no session, no cookie)
        log_in user
        @current_user = user
      end
    end
  end

  # Returns true if user logged in, or false
  def logged_in?
    !current_user.nil?
  end

  # Set remember_digest to nil in db, and delete cookies.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Delete the session cookie and set current user to nil.
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

end
