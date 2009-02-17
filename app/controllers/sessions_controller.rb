# This controller handles the login/logout function of the site.
class SessionsController < ApplicationController
  before_filter :login_required, :except=> [:new, :create]

  # render new.rhtml
  def new
  end

  def create
    logout_keeping_session!
    if using_open_id?
      login_with_openid
    else
      note_failed_signin
      render :action => 'new'
    end
  end

  def destroy
    logout_killing_session!
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end

  protected
  # Track failed login attempts
  def note_failed_signin
    flash[:error] = "Couldn't log you in as '#{params[:openid_identifier]}'"
    logger.warn "Failed login for '#{params[:openid_identifier]}' from #{request.remote_ip} at #{Time.now.utc}"
  end

  def login_with_openid
    authenticate_with_open_id do |result, openid_identifier|
      if result.successful?
        if user = User.find_by_openid_identifier(openid_identifier)
          successful_login(user)
        else
          signup_with_openid(openid_identifier)
        end
      else
        note_failed_signin
        render :action => 'new'
      end
    end
  end

  def successful_login(user)
    return_to = session[:return_to]||root_url
    reset_session
    self.current_user = user
    new_cookie_flag = (params[:remember_me] == "1")
    handle_remember_cookie! new_cookie_flag
    flash[:notice] ||= "Logged in successfully"
    redirect_back_or_default(return_to)
  end

  def signup_with_openid(openid_identifier)
    session[:openid_identifier] = openid_identifier
    @user = User.new

    render :template => "users/new"
  end
end

