class UsersController < ApplicationController
  before_filter :login_required, :except => [:create]
  def create
    logout_keeping_session!
    @user = User.new(params[:user].merge(:openid_identifier => session[:openid_identifier]))
    success = @user && @user.save
    if success && @user.errors.empty?
      session[:openid_identifier] = nil
      reset_session
      self.current_user = @user # !! now logged in
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end
end
