class Team < ActiveRecord::Base
  belongs_to :league

  attr_accessible :name, :manager_email_address

  has_many :team_members
  has_many :players, :through => :team_members, :source => :user

  # Team manager
  # Coach, Asst Coach, etc (title attached to the relation)
  has_many :managers, :through => :team_managers, :source => :user, :class_name => User
  has_many :team_managers

  has_many :home_games, :class_name => Game, :foreign_key => "home_id"
  has_many :away_games, :class_name => Game, :foreign_key => "away_id"

  def manager_email_address
    @manager_email_address
  end

  def games
    (home_games + away_games).sort_by {|g| g.start_time }
  end

  def manager
    self.team_managers.select {|tm| tm.title == 'manager' }.first.user rescue nil
  end

  def manager_email_address=(email)
    manager_user = User.where(:email=>email).first
    self.add_manager(manager_user, "manager") if manager_user
  end

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
