class Team < ActiveRecord::Base
  belongs_to :league

  attr_accessible :name, :manager_email_address

  has_many :team_members
  has_many :players, :through => :team_members, :source => :user

  has_many :managers, :through => :team_managers, :source => :account
  has_many :team_managers

  has_many :home_games, :class_name => Game, :foreign_key => "home_id"
  has_many :away_games, :class_name => Game, :foreign_key => "away_id"

  belongs_to :message_board

  attr_accessor :manager_email_address

  before_save { |team| team.name = team.name.downcase.strip }

  before_save do |team|
    if (team.message_board.nil?)
      mb = MessageBoard.create!
      team.message_board_id = mb.id
    end
  end

  validates_uniqueness_of :name

  def games
    (home_games + away_games).sort_by {|g| g.start_time }
  end
end
