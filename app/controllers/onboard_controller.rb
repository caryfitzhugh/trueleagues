class OnboardController < ApplicationController
  include OnboardHelper

  def resend_invitation
    @account = Account.find_by_id(params[:account_id])

    if @account
      if @account.pending?
        @account.resend_invite!
        flashback(:success, "Resent invitation to #{@account.email}")
      else

      end
    else
      head 404
    end

  end

  # This accepts a new incoming account.
  # Sends them to the password update page to set their password
  # And redirects them to the go_to destination
  def get_onboard_account

    @token = params[:token]
    @destination = Base64.decode64(params[:destination] || "")
    @description = Base64.decode64(params[:description] || "")

    @account  = Account.find(params[:account_id])

    decoded_token = token_for_onboard(@account, @destination, @description)

    # Check the validity of the token
    if (decoded_token == @token)
      render

    else
      render "shared/403", :locals => {:message => "The token / url you have followed is invalid." }
    end

  end

  def onboard_account

    @token = params[:token]
    @destination = params[:destination]
    @description = params[:description]
    @account  = Account.find(params[:account_id])

    @account.password = params[:account][:password]
    @account.password_confirmation = params[:account][:password_confirmation]
    @account.pending = false

    if @account.save
      redirect_to @destination
    else
      render :action => "get_onboard_account"
    end
  end
end
