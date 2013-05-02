class AccountMailer < ActionMailer::Base
  default from:     "system@trueleagues.com"

  def league_created_email(data)
    @email = data[:email]
    @league  = League.find(data[:league_id])
    @url   = data[:url]

    mail(:to => @email, :subject => "You are now managing #{@league.name}! Let's get playing!")
  end

  def player_added_to_team_email(data)
    @email = data[:email]
    @team  = Team.find(data[:team_id])
    @user  = User.find(data[:user_id])
    @url   = data[:url]

    mail(:to => @email, :subject => "#{@user.name}: you are now on #{@team.name}! Let's get playing!")
  end
  def team_created_email(data)
    @email = data[:email]
    @team  = Team.find(data[:team_id])
    @url   = data[:url]

    mail(:to => @email, :subject => "Your team: #{@team.name} is ready to manage!")
  end
end
