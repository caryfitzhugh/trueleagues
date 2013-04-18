class UserMailer < ActionMailer::Base
  default from: "manager@soccer-club-manager.com"

  def team_created_email(user, team, url)
    @user = user
    @team = team
    @url  = url

    mail(:to => user.email, :subject => "Your team: #{team.name} is ready to manage!")
  end
end
