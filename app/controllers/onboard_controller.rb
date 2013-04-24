class OnboardController < ApplicationController
  include OnboardHelper

  # This accepts a new incoming user.
  # Sends them to the password update page to set their password
  # And redirects them to the go_to destination
  def get_onboard_user

    @token = params[:token]
    @destination = Base64.decode64(params[:destination] || "")
    @description = Base64.decode64(params[:description] || "")

    @user  = User.find(params[:user_id])

    decoded_token = token_for_onboard(@user, @destination, @description)

    # Check the validity of the token
    if (decoded_token == @token)
      render

    else
      render "shared/403", :locals => {:message => "The token / url you have followed is invalid." }
    end

  end

  def onboard_user

    @token = params[:token]
    @destination = params[:destination]
    @description = params[:description]
    @user  = User.find(params[:user_id])

    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    @user.pending = false

    if @user.save
      redirect_to @destination
    else
      render :action => "get_onboard_user"
    end
  end
end
