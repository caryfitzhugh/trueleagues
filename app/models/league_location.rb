class LeagueLocation < ActiveRecord::Base
  belongs_to :league
  belongs_to :location
end
