class League < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :name, :start_date, :end_date, :scoring_system
  has_many :teams

  has_many :managers, :through => :league_managers, :source => :account
  has_many :league_managers

  belongs_to :message_board

  has_many :games
  has_many :locations, :through => :league_locations
  has_many :league_locations

  validates_date :start_date, :before => :end_date
  validates_date :end_date
  validates_presence_of :name

  before_save { |league| league.name = league.name.downcase.strip }

  before_save do |league|
    if (league.message_board.nil?)
      mb = MessageBoard.create!
      league.message_board_id = mb.id
    end
  end

  SCORING_SYSTEMS = %w( default )

  def standings
    teams.map do |team|
      OpenStruct.new(:team => team, :points => team.id )
    end
  end
end
