class ApplicationController < ActionController::Base
  protect_from_forgery

  # before_filter :authenticate_user!
  # current_user
  # user_session
  def flashback(type, msg)
    render "shared/flashback", :locals => { type.to_sym => msg}
  end
end
