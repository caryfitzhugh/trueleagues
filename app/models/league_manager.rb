class LeagueManager < ActiveRecord::Base
  belongs_to :league
  belongs_to :user
  validates_presence_of :league
  validates_presence_of :user
end
