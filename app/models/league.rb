class League < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :name, :start_date, :end_date, :scoring_system, :manager_email_address
  has_many :teams

  has_many :managers, :through => :league_managers, :source => :account
  has_many :league_managers

  has_many :games

  validates_date :start_date
  validates_date :end_date
  validates_date :start_date, :before => :end_date
  validates_presence_of :name

  before_save { |league| league.name = league.name.downcase.strip }

  attr_accessor :manager_email_address

  SCORING_SYSTEMS = %w( default )

  def standings
    teams.map do |team|
      OpenStruct.new(:team => team, :points => team.id )
    end
  end
end
