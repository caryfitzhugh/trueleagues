class LeagueLocation < ActiveRecord::Base
  belongs_to :league
  belongs_to :location

  validates_uniqueness_of :league_id, :scope => [:location_id]
end
