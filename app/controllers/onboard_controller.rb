class OnboardController < ApplicationController
  include OnboardHelper

  def signup_before_action
    go_to = Base64.decode64(params[:go_to])
    user_email = params[:email]
    session["user_return_to"] = go_to
    redirect_to new_user_registration_path(:user => {:email => user_email}, :description => params[:description])
  end
end
