class UserMailer < ActionMailer::Base
  default from: "manager@soccer-club-manager.com"

  def player_added_to_team_email(data)
    @email = data[:email]
    @team  = Team.find(data[:team_id])
    @url   = data[:url]

    mail(:to => @email, :subject => "You are now on #{@team.name}! Let's get playing!")
  end
  def team_created_email(data)
    @email = data[:email]
    @team  = Team.find(data[:team_id])
    @url   = data[:url]

    mail(:to => @email, :subject => "Your team: #{@team.name} is ready to manage!")
  end
end
