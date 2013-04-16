class Team < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :team_members
  has_many :players, :through => :team_members, :source => :user

  # Team manager
  # Coach, Asst Coach, etc (title attached to the relation)
  has_many :managers, :through => :team_managers, :source => :user, :class_name => User
  has_many :team_managers

  has_many :home_games, :class_name => Game
  has_many :away_games, :class_name => Game

  def remove_player(user)
    self.players = self.players.reject {|p| p.id == user.id  }
  end

  def add_manager(user, title)
    tm = TeamManager.new(:title => title)
    tm.user = user
    tm.team = self
    self.team_managers << tm
  end

end
