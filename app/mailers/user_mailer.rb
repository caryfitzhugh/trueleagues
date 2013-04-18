class UserMailer < ActionMailer::Base
  default from: "manager@soccer-club-manager.com"

  def team_created_email(email, team, url)
    @email = email
    @team = team
    @url  = url

    mail(:to => @email, :subject => "Your team: #{team.name} is ready to manage!")
  end
end
