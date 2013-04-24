class UserMailer < ActionMailer::Base
  default from: "manager@soccer-club-manager.com"

  def player_added_to_team_email(email, team, url)
    @email = email
    @team = team
    @url  = url

    mail(:to => @email, :subject => "You are now on #{team.name}! Let's get playing!")
  end
  def team_created_email(email, team, url)
    @email = email
    @team = team
    @url  = url

    mail(:to => @email, :subject => "Your team: #{team.name} is ready to manage!")
  end
end
