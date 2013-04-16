class League < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :teams, :through => :league_teams
  has_many :league_teams

  has_many :managers, :through => :league_managers, :source => :user
  has_many :league_managers

  has_many :games

  def add_team(team)
    league_team = LeagueTeam.new
    league_team.team = team
    league_team.league = self
    league_teams << league_team
  end
end
